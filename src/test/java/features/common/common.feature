Feature: Common Functions and Utilities

Background:
    * configure headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    * configure retry = { count: 3, interval: 2000 }
    * url baseUrl

Scenario: Generate Random User Data
    * def randomUser =
    """
    function() {
        var timestamp = new Date().getTime();
        return {
            username: 'user_' + timestamp,
            email: 'user_' + timestamp + '@test.com',
            password: 'Test@123',
            firstName: 'Test',
            lastName: 'User',
            phone: '1234567890'
        };
    }
    """
    * def userData = randomUser()

Scenario: Generate Random Product Data
    * def randomProduct =
    """
    function() {
        var categories = ['electronics', 'clothing', 'books', 'home', 'sports'];
        var randomCategory = categories[Math.floor(Math.random() * categories.length)];
        var timestamp = new Date().getTime();
        return {
            title: 'Product ' + timestamp,
            price: Math.floor(Math.random() * 1000) + 10,
            category: randomCategory,
            description: 'Test product description for ' + randomCategory,
            image: 'https://picsum.photos/seed/' + timestamp + '/200/200.jpg'
        };
    }
    """
    * def productData = randomProduct()

Scenario: Setup Authentication Token
    * def authLogin =
    """
    function(username, password) {
        var response = karate.call('classpath:features/authentication/login.feature', { 
            username: username || 'john_doe', 
            password: password || 'password123' 
        });
        return response.authToken;
    }
    """

Scenario: Validate API Response
    * def validateResponse =
    """
    function(response, expectedStatus) {
        if (response.status !== expectedStatus) {
            karate.fail('Expected status ' + expectedStatus + ' but got ' + response.status);
        }
        return true;
    }
    """

Scenario: Extract Error Details
    * def getErrorDetails =
    """
    function(response) {
        if (response.response && response.response.error) {
            return {
                message: response.response.error.message,
                code: response.response.error.code,
                details: response.response.error.details
            };
        }
        return { message: 'Unknown error', code: 'UNKNOWN', details: null };
    }
    """

Scenario: Generate Test Report Data
    * def generateReportData =
    """
    function(testName, status, duration, errors) {
        return {
            testName: testName,
            status: status,
            duration: duration,
            timestamp: new Date().toISOString(),
            errors: errors || [],
            environment: karate.env || 'dev'
        };
    }
    """
