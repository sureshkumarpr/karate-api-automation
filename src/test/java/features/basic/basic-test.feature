Feature: Basic Karate Test
    Simple test to verify Karate is working

    @smoke
    Scenario: Basic functionality test
        * def value = 'hello world'
        * match value == 'hello world'
        * def number = 42
        * match number == 42
        * def array = [1, 2, 3]
        * match array contains 2
        * karate.log('Basic test completed successfully')
