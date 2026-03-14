Feature: User Authentication API Tests
    Test user login, token generation, and session management

    @smoke @regression
    Scenario: Successful user login with valid credentials
        Given path endpoints.auth.login
        And request testData.users.valid
        When method post
        Then status 200
        And match response == { token: '#string', expiresIn: '#number', refreshToken: '#string' }
        And match response.token =~ '[a-zA-Z0-9-._~+/]+=*'
        * def authToken = response.token
        * karate.log('Authentication token generated:', authToken)

    @regression
    Scenario: Login attempt with invalid credentials should fail
        Given path endpoints.auth.login
        And request testData.users.invalid
        When method post
        Then status 401
        And match response == { error: { message: '#string', code: 'INVALID_CREDENTIALS' } }
        And match response.error.message contains 'Invalid'

    @regression
    Scenario Outline: Login validation with missing required fields
        Given path endpoints.auth.login
        And request { username: '<username>', password: '<password>' }
        When method post
        Then status <status>
        And match response == { error: { message: '#string', code: '<errorCode>' } }

        Examples:
            | username | password | status | errorCode           |
            |          | password123 | 400   | MISSING_USERNAME    |
            | john_doe |            | 400   | MISSING_PASSWORD    |
            |          |            | 400   | MISSING_CREDENTIALS |

    @smoke
    Scenario: Token validation and session expiry
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def authToken = loginResult.authToken
        Given path endpoints.auth.profile
        And header Authorization = 'Bearer ' + authToken
        When method get
        Then status 200
        And match response == { id: '#number', username: '#string', email: '#string' }

    @regression
    Scenario: Access protected endpoint without token should fail
        Given path endpoints.auth.profile
        When method get
        Then status 401
        And match response == { error: { message: '#string', code: 'MISSING_TOKEN' } }

    @regression
    Scenario: Access protected endpoint with invalid token should fail
        Given path endpoints.auth.profile
        And header Authorization = 'Bearer invalid_token_123'
        When method get
        Then status 401
        And match response == { error: { message: '#string', code: 'INVALID_TOKEN' } }

    @regression
    Scenario: Token refresh functionality
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def refreshToken = loginResult.refreshToken
        Given path '/auth/refresh'
        And request { refreshToken: refreshToken }
        When method post
        Then status 200
        And match response == { token: '#string', expiresIn: '#number', refreshToken: '#string' }
        * def newToken = response.token
        * karate.log('Token refreshed successfully:', newToken)
