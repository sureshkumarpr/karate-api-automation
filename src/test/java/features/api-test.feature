Feature: API Test with Real Endpoints

Background:
    * url 'https://jsonplaceholder.typicode.com'

Scenario: Test GET request - Should Pass
    Given path '/posts/1'
    When method GET
    Then status 200
    And match response.userId == 1
    And match response.id == 1

Scenario: Test POST request - Should Pass
    Given path '/posts'
    And request { title: 'Test Post', body: 'Test Body', userId: 1 }
    When method POST
    Then status 201
    And match response.title == 'Test Post'
    And match response.userId == 1

Scenario: Test invalid endpoint - Should Fail
    Given path '/invalid-endpoint'
    When method GET
    Then status 404

Scenario: Test invalid POST data - Should Fail
    Given path '/posts'
    And request { invalidField: 'invalid' }
    When method POST
    Then status 400

Scenario: Test PUT request - Should Pass
    Given path '/posts/1'
    And request { title: 'Updated Post', body: 'Updated Body' }
    When method PUT
    Then status 200
    And match response.title == 'Updated Post'

Scenario: Test DELETE request - Should Pass
    Given path '/posts/1'
    When method DELETE
    Then status 200
