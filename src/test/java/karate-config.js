function() {
    // Environment-specific configuration
    var env = karate.env || 'dev'; // default to 'dev'
    
    var config = {
        baseUrl: 'https://fakestoreapi.com', // Using FakeStoreAPI for demo
        mockBaseUrl: 'http://localhost:8080',
        
        // API Endpoints
        endpoints: {
            auth: {
                login: '/auth/login',
                register: '/users',
                profile: '/users/1'
            },
            products: {
                list: '/products',
                search: '/products',
                details: '/products/',
                categories: '/products/categories'
            },
            cart: {
                get: '/carts/1',
                add: '/carts',
                update: '/carts/1',
                delete: '/carts/1'
            },
            orders: {
                create: '/orders',
                get: '/orders/',
                list: '/carts/1'
            }
        },
        
        // Test Data
        testData: {
            users: {
                valid: {
                    username: 'john_doe',
                    password: 'password123',
                    email: 'john@example.com'
                },
                invalid: {
                    username: 'invalid_user',
                    password: 'wrong_password'
                }
            },
            products: {
                sample: {
                    title: 'Test Product',
                    price: 99.99,
                    category: 'electronics',
                    description: 'Test product description'
                }
            }
        },
        
        // Performance Test Configuration
        performance: {
            concurrentUsers: 10,
            rampUpTime: 5,
            testDuration: 30
        },
        
        // Report Configuration
        report: {
            outputDir: 'target/karate-reports',
            includeTags: ['smoke', 'regression', 'performance']
        }
    };
    
    // Override for different environments
    if (env === 'prod') {
        config.baseUrl = 'https://api.production-ecommerce.com';
    } else if (env === 'staging') {
        config.baseUrl = 'https://api.staging-ecommerce.com';
    } else if (env === 'mock') {
        config.baseUrl = config.mockBaseUrl;
    }
    
    // Global functions available across all feature files
    karate.log('Environment:', env);
    karate.log('Base URL:', config.baseUrl);
    
    // Common headers
    config.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
    };
    
    return config;
}
