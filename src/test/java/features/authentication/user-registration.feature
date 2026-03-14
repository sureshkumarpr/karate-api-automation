Feature: User Registration API Tests
    Test user registration, validation, and account management

    @smoke @regression
    Scenario: Successful user registration with valid data
        * def userData = call read('classpath:features/common/common.feature@Generate Random User Data').userData
        Given path endpoints.auth.register
        And request userData
        When method post
        Then status 201
        And match response == { 
            id: '#number', 
            username: userData.username, 
            email: userData.email,
            message: '#string'
        }
        * def userId = response.id
        * karate.log('User registered successfully with ID:', userId)

    @regression
    Scenario Outline: Registration validation with invalid data
        Given path endpoints.auth.register
        And request
        """
        {
            username: '<username>',
            email: '<email>',
            password: '<password>',
            firstName: '<firstName>',
            lastName: '<lastName>'
        }
        """
        When method post
        Then status <status>
        And match response == { error: { message: '#string', field: '<field>', code: '<errorCode>' } }

        Examples:
            | username | email           | password | firstName | lastName | status | field     | errorCode           |
            | null     | test@test.com   | Pass123  | Test      | User     | 400    | username  | INVALID_USERNAME    |
            | user123  | null            | Pass123  | Test      | User     | 400    | email     | INVALID_EMAIL       |
            | user123  | test@test.com   | null     | Test      | User     | 400    | password  | INVALID_PASSWORD    |
            | null     | null            | null     | null      | null     | 400    | multiple | MISSING_FIELDS      |
            | ab       | test@test.com   | Pass123  | Test      | User     | 400    | username  | USERNAME_TOO_SHORT  |
            | user123  | invalid-email   | Pass123  | Test      | User     | 400    | email     | INVALID_EMAIL_FORMAT |

    @regression
    Scenario: Registration with duplicate username should fail
        * def userData = call read('classpath:features/common/common.feature@Generate Random User Data').userData
        # First registration
        Given path endpoints.auth.register
        And request userData
        When method post
        Then status 201
        # Second registration with same username
        Given path endpoints.auth.register
        And request userData
        When method post
        Then status 409
        And match response == { error: { message: '#string', code: 'USERNAME_EXISTS' } }

    @regression
    Scenario: Registration with duplicate email should fail
        * def userData = call read('classpath:features/common/common.feature@Generate Random User Data').userData
        # First registration
        Given path endpoints.auth.register
        And request userData
        When method post
        Then status 201
        # Second registration with same email but different username
        * userData.username = 'different_user_' + new Date().getTime()
        Given path endpoints.auth.register
        And request userData
        When method post
        Then status 409
        And match response == { error: { message: '#string', code: 'EMAIL_EXISTS' } }

    @smoke
    Scenario: Password strength validation
        * def userData = call read('classpath:features/common/common.feature@Generate Random User Data').userData
        * def weakPasswords = ['123', 'password', 'abc', '12345678', 'qwerty']
        * for (i = 0; i < weakPasswords.length; i++)
            * userData.password = weakPasswords[i]
            Given path endpoints.auth.register
            And request userData
            When method post
            Then status 400
            And match response == { error: { message: '#string', field: 'password', code: 'WEAK_PASSWORD' } }

    @regression
    Scenario: Email format validation
        * def userData = call read('classpath:features/common/common.feature@Generate Random User Data').userData
        * def invalidEmails = ['test@', '@test.com', 'test.com', 'test@.com', 'test@test', 'test@test..com']
        * for (i = 0; i < invalidEmails.length; i++)
            * userData.email = invalidEmails[i]
            Given path endpoints.auth.register
            And request userData
            When method post
            Then status 400
            And match response == { error: { message: '#string', field: 'email', code: 'INVALID_EMAIL_FORMAT' } }

    @regression
    Scenario: Username format validation
        * def userData = call read('classpath:features/common/common.feature@Generate Random User Data').userData
        * def invalidUsernames = ['ab', 'user@name', 'user name', 'user.name', '12345678901234567890']
        * for (i = 0; i < invalidUsernames.length; i++)
            * userData.username = invalidUsernames[i]
            Given path endpoints.auth.register
            And request userData
            When method post
            Then status 400
            And match response == { error: { message: '#string', field: 'username', code: 'INVALID_USERNAME_FORMAT' } }
