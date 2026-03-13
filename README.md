# E-commerce API Test Automation Suite

A comprehensive API test automation framework built with Karate for testing e-commerce REST endpoints. This project demonstrates best practices in API testing, performance testing, and CI/CD integration.

**Author**: Divya.V, II MSc Computer Science, Gobi Arts and Science College (Autonomous), Gobichettipalayam, Erode District, Pin 638458

## 🎯 Project Overview

This 4-month Master's project develops a production-ready API test automation suite that covers:

- **Authentication & Authorization**: Login, registration, token management
- **Product Catalog**: Search, filtering, pagination, CRUD operations
- **Shopping Cart**: Add, update, remove items, inventory checks
- **Checkout & Orders**: Payment processing, order creation, tracking
- **Performance Testing**: Load testing with Gatling integration
- **CI/CD Pipeline**: Automated testing and deployment

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Test Architecture                        │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐         │
│  │   Karate    │  │   Gatling   │  │   Maven     │         │
│  │   Framework │  │ Performance │  │   Build     │         │
│  │             │  │   Testing   │  │   System    │         │
│  └─────────────┘  └─────────────┘  └─────────────┘         │
│         │                 │                 │              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐         │
│  │   Feature   │  │   Reports   │  │   CI/CD     │         │
│  │   Files     │  │ Generation  │  │   Pipeline  │         │
│  └─────────────┘  └─────────────┘  └─────────────┘         │
└─────────────────────────────────────────────────────────────┘
```

## 📁 Project Structure

```
karate-api-automation/
├── src/test/java/
│   ├── com/ecommerce/karate/
│   │   └── TestRunner.java              # Main test runner
│   ├── features/
│   │   ├── authentication/              # Auth test scenarios
│   │   │   ├── login.feature
│   │   │   └── user-registration.feature
│   │   ├── product-catalog/              # Product tests
│   │   │   ├── product-search.feature
│   │   │   └── product-management.feature
│   │   ├── shopping-cart/                # Cart tests
│   │   │   ├── cart-operations.feature
│   │   │   └── cart-validation.feature
│   │   ├── checkout-orders/             # Checkout tests
│   │   │   ├── checkout-process.feature
│   │   │   └── order-management.feature
│   │   └── common/
│   │       └── common.feature           # Common utilities
│   ├── performance/                     # Performance tests
│   │   ├── AuthenticationPerformanceTest.java
│   │   ├── CartPerformanceTest.java
│   │   ├── ProductCatalogPerformanceTest.java
│   │   └── CheckoutPerformanceTest.java
│   └── karate-config.js                 # Configuration
├── .github/workflows/                   # CI/CD pipelines
│   ├── ci-cd.yml
│   └── weekly-performance.yml
├── pom.xml                              # Maven configuration
└── README.md                            # This file
```

## 🚀 Quick Start

### Prerequisites

- Java 11 or higher
- Maven 3.6+
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/karate-api-automation.git
   cd karate-api-automation
   ```

2. **Install dependencies**
   ```bash
   mvn clean install
   ```

3. **Run tests**
   ```bash
   # Run all tests
   mvn test
   
   # Run smoke tests only
   mvn test -Dkarate.options="--tags @smoke"
   
   # Run regression tests only
   mvn test -Dkarate.options="--tags @regression"
   ```

### Running Specific Tests

```bash
# Authentication tests
mvn test -Dkarate.options="classpath:features/authentication"

# Product catalog tests
mvn test -Dkarate.options="classpath:features/product-catalog"

# Shopping cart tests
mvn test -Dkarate.options="classpath:features/shopping-cart"

# Checkout and order tests
mvn test -Dkarate.options="classpath:features/checkout-orders"
```

## 🧪 Test Scenarios

### Authentication Tests (`@smoke @regression`)

- ✅ User login with valid credentials
- ✅ Login with invalid credentials (negative testing)
- ✅ Token generation and validation
- ✅ Token refresh functionality
- ✅ User registration with validation
- ✅ Password strength validation
- ✅ Email format validation

### Product Catalog Tests (`@smoke @regression`)

- ✅ Get all products
- ✅ Search products by keyword
- ✅ Filter products by category
- ✅ Filter products by price range
- ✅ Product pagination
- ✅ Get product details by ID
- ✅ Sort products by price
- ✅ Product CRUD operations (admin)

### Shopping Cart Tests (`@smoke @regression`)

- ✅ Add items to cart
- ✅ Update cart item quantity
- ✅ Remove items from cart
- ✅ View cart contents
- ✅ Clear entire cart
- ✅ Apply discounts
- ✅ Inventory validation
- ✅ Cart persistence

### Checkout & Order Tests (`@smoke @regression`)

- ✅ Complete checkout process
- ✅ Payment method validation
- ✅ Address validation
- ✅ Order creation
- ✅ Order status tracking
- ✅ Order cancellation
- ✅ Order history
- ✅ Refund processing

## 📊 Performance Testing

Performance tests are implemented using Karate's Gatling integration:

### Test Categories

1. **Authentication Performance**
   - Concurrent login requests
   - Token validation under load
   - User registration performance

2. **Product Catalog Performance**
   - Product search under load
   - Filtering and pagination performance
   - Product details retrieval

3. **Shopping Cart Performance**
   - Cart operations under concurrency
   - Inventory check performance
   - Cart update operations

4. **Checkout Performance**
   - Payment processing performance
   - Order creation under load
   - Order tracking performance

### Running Performance Tests

```bash
# Run all performance tests
mvn gatling:test -Pperformance

# Run specific performance test
mvn gatling:test -Pperformance \
  -Dgatling.simulationClass=performance.CartPerformanceTest
```

## 🔄 CI/CD Pipeline

### Automated Workflows

1. **Main CI/CD Pipeline** (`.github/workflows/ci-cd.yml`)
   - ✅ Build and test on push/PR
   - ✅ Smoke, regression, and performance tests
   - ✅ Security scanning with Trivy
   - ✅ Code quality analysis with SonarCloud
   - ✅ Test report generation and upload
   - ✅ Documentation deployment

2. **Weekly Performance Tests** (`.github/workflows/weekly-performance.yml`)
   - ✅ Scheduled performance benchmarks
   - ✅ Performance comparison reports
   - ✅ Automated performance issue creation

### Pipeline Features

- **Parallel Execution**: Tests run in parallel for faster execution
- **Environment Support**: Dev, staging, and production configurations
- **Artifact Management**: Test reports and performance metrics stored
- **Notification System**: Success/failure notifications
- **Security Scanning**: Automated vulnerability detection

## 📈 Reports and Metrics

### Test Reports

- **Karate HTML Reports**: Interactive test execution reports
- **Gatling Performance Reports**: Detailed performance metrics
- **Coverage Reports**: Code coverage analysis
- **Security Reports**: Vulnerability scan results

### Key Metrics Tracked

- **Response Times**: Average, min, max response times
- **Throughput**: Requests per second
- **Success Rates**: Test pass/fail percentages
- **Error Rates**: API error frequency
- **Performance Trends**: Historical performance data

## 🛠️ Configuration

### Environment Configuration (`karate-config.js`)

```javascript
// Environment-specific settings
var config = {
    baseUrl: 'https://fakestoreapi.com',  // Default API endpoint
    endpoints: {
        auth: { login: '/auth/login', ... },
        products: { list: '/products', ... },
        cart: { get: '/carts/1', ... },
        orders: { create: '/orders', ... }
    },
    testData: {
        users: { valid: {...}, invalid: {...} },
        products: { sample: {...} }
    }
};
```

### Maven Configuration

- **Java Version**: 11
- **Karate Version**: 1.4.0
- **Gatling Integration**: Performance testing
- **Parallel Execution**: 4 threads
- **Test Reports**: HTML and JSON formats

## 🧩 Test Data Management

### Test Data Sources

1. **Static Test Data**: Defined in `karate-config.js`
2. **Dynamic Test Data**: Generated using JavaScript functions
3. **External Data**: JSON files in `test-data/` directory
4. **Mock Data**: Mock server responses for isolated testing

### Data-Driven Testing

```gherkin
Scenario Outline: Search products with different keywords
    Given path endpoints.products.search
    And param q = '<keyword>'
    When method get
    Then status 200
    
    Examples:
        | keyword    |
        | laptop     |
        | phone      |
        | clothing   |
```

## 🔧 Advanced Features

### 1. API Mocking

```javascript
// Mock server configuration for isolated testing
def mockResponse = {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
    body: { products: [...] }
};
```

### 2. Parallel Execution

```xml
<!-- Maven plugin configuration for parallel tests -->
<plugin>
    <groupId>com.intuit.karate</groupId>
    <artifactId>karate-maven-plugin</artifactId>
    <configuration>
        <parallel>true</parallel>
        <threadCount>4</threadCount>
    </configuration>
</plugin>
```

### 3. Custom Assertions

```javascript
// Custom validation functions
def validateResponse = function(response, expectedStatus) {
    if (response.status !== expectedStatus) {
        karate.fail('Expected status ' + expectedStatus);
    }
    return true;
};
```

## 📝 Best Practices Implemented

1. **Modular Test Design**: Feature files organized by functionality
2. **Reusable Components**: Common functions in `common.feature`
3. **Data-Driven Testing**: Scenario outlines with examples
4. **Environment Configuration**: Separate configs for dev/staging/prod
5. **Error Handling**: Comprehensive negative test scenarios
6. **Performance Testing**: Load testing with realistic scenarios
7. **CI/CD Integration**: Automated testing and deployment
8. **Documentation**: Comprehensive README and inline documentation

## 🚀 Deployment

### Local Development

```bash
# Run tests locally
mvn test

# Generate reports
mvn karate:report

# Run performance tests
mvn gatling:test -Pperformance
```

### CI/CD Deployment

- **Automated**: Tests run on every push and PR
- **Scheduled**: Weekly performance tests
- **Manual**: Trigger specific test suites via workflow dispatch

### Production Considerations

- **Environment Variables**: Secure configuration management
- **Secret Management**: API keys and credentials
- **Monitoring**: Real-time test execution monitoring
- **Alerting**: Failure notifications and escalation

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For questions and support:

- 📧 Email: your-email@example.com
- 🐛 Issues: [GitHub Issues](https://github.com/your-username/karate-api-automation/issues)
- 📖 Documentation: [Project Wiki](https://github.com/your-username/karate-api-automation/wiki)

## 🎓 Academic Context

This project is part of a 4-month Master's program in Software Engineering, demonstrating:

- **API Testing Methodologies**: Comprehensive test coverage
- **Performance Engineering**: Load testing and optimization
- **DevOps Practices**: CI/CD pipeline implementation
- **Software Quality**: Automated testing and reporting
- **Research Skills**: Framework evaluation and implementation

### Project Timeline

- **Month 1**: Setup and basic Karate implementation
- **Month 2**: Core functionality and test scenarios
- **Month 3**: Advanced features and performance testing
- **Month 4**: Integration, documentation, and deployment

### Author Information

**Divya.V**  
II MSc Computer Science  
Gobi Arts and Science College (Autonomous)  
Gobichettipalayam, Erode District  
Tamil Nadu, Pin 638458  

**Academic Year**: 2024-2025  
**Project Guide**: [Guide Name]  
**Submission Date**: March 2026

---

**Built with ❤️ using Karate Framework by Divya.V**
