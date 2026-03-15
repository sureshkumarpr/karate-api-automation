Feature: User Authentication API Testing
  As an e-commerce user
  I want to authenticate and manage my account
  So that I can access personalized services

Background:
  * url 'https://api.ossjavahub.com'
  * header Content-Type = 'application/json'
  * header Accept = 'application/json'

Scenario: User login - Should Pass
  Given path '/auth/login'
  And request { email: 'user@ossjavahub.com', password: 'password123' }
  When method POST
  Then status 200
  And match response.success == true
  And match response.token == '#string'
  And match response.user.email == 'user@ossjavahub.com'
  And match response.user.id == '#number'

Scenario: User registration - Should Pass
  Given path '/auth/register'
  And request { name: 'Test User', email: 'test@ossjavahub.com', password: 'testpass123', phone: '1234567890' }
  When method POST
  Then status 201
  And match response.success == true
  And match response.message == 'User registered successfully'
  And match response.user.email == 'test@ossjavahub.com'

Scenario: Get user profile - Should Pass
  Given path '/auth/profile'
  And header Authorization = 'Bearer valid-token-here'
  When method GET
  Then status 200
  And match response.name == '#string'
  And match response.email == '#string'
  And match response.id == '#number'

Scenario: Update user profile - Should Pass
  Given path '/auth/profile'
  And header Authorization = 'Bearer valid-token-here'
  And request { name: 'Updated Name', phone: '9876543210' }
  When method PUT
  Then status 200
  And match response.success == true
  And match response.user.name == 'Updated Name'

Scenario: User logout - Should Pass
  Given path '/auth/logout'
  And header Authorization = 'Bearer valid-token-here'
  When method POST
  Then status 200
  And match response.success == true
  And match response.message == 'Logout successful'

Scenario: Login with invalid credentials - Should Fail
  Given path '/auth/login'
  And request { email: 'invalid@ossjavahub.com', password: 'wrongpassword' }
  When method POST
  Then status 401
  And match response.error == 'Invalid credentials'

Scenario: Login with missing fields - Should Fail
  Given path '/auth/login'
  And request { email: 'user@ossjavahub.com' }
  When method POST
  Then status 400
  And match response.error contains 'Required fields missing'

Scenario: Access profile without token - Should Fail
  Given path '/auth/profile'
  When method GET
  Then status 401
  And match response.error == 'Authorization token required'

Scenario Outline: Data-driven login attempts - Should Pass/Fail
  Given path '/auth/login'
  And request { email: '<email>', password: '<password>' }
  When method POST
  Then status <status>
  And match response contains { <responseField>: '<responseValue>' }

  Examples:
    | email                    | password     | status | responseField | responseValue     |
    | user@ossjavahub.com      | password123  | 200    | success       | true              |
    | admin@ossjavahub.com     | admin123     | 200    | success       | true              |
    | invalid@ossjavahub.com   | wrongpass    | 401    | error         | Invalid credentials |
    | ''                       | password123  | 400    | error         | Required fields missing |

Scenario Outline: Registration validation with invalid data - Should Fail
  Given path '/auth/register'
  And request { username: '<username>', email: '<email>', password: '<password>', firstName: '<firstName>', lastName: '<lastName>' }
  When method POST
  Then status <status>
  And match response.errorCode == '<errorCode>'

  Examples:
    | username | email              | password | firstName | lastName | status | errorCode        |
    | null     | test@test.com      | Pass123  | Test       | User     | 400              | MISSING_FIELDS |
    | username | invalid-email      | Pass123  | Test       | User     | 400              | INVALID_EMAIL |
    | user123  | null              | Pass123  | Test       | User     | 400              | MISSING_FIELDS |
    | user123  | test@test.com      | null     | Test       | User     | 400              | MISSING_FIELDS |
    | user123  | test@test.com      | Pass123  | null       | User     | 400              | MISSING_FIELDS |
    | user123  | test@test.com      | Pass123  | Test       | null     | 400              | MISSING_FIELDS |
    | user123  | test@test.com      | Pass123  | Test       | User     | 400              | MISSING_FIELDS |
    | ab       | test@test.com      | Pass123  | Test       | User     | 400              | USERNAME_TOO_SHORT |
    | user123  | invalid-email      | Pass123  | Test       | User     | 400              | INVALID_EMAIL_FORMAT |
    | @regression | test@test.com | Pass123 | Test | User | 400 | INVALID_USERNAME_FORMAT |
