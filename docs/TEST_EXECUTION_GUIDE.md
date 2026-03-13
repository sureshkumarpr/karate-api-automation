# Test Execution Guide

This guide provides detailed instructions for executing the e-commerce API test automation suite.

**Author**: Divya.V, II MSc Computer Science, Gobi Arts and Science College (Autonomous), Gobichettipalayam, Erode District, Pin 638458

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Environment Setup](#environment-setup)
3. [Running Tests](#running-tests)
4. [Test Categories](#test-categories)
5. [Performance Testing](#performance-testing)
6. [Troubleshooting](#troubleshooting)
7. [Best Practices](#best-practices)

## 🔧 Prerequisites

### Required Software

| Software | Version | Purpose |
|----------|---------|---------|
| Java | 11+ | Runtime environment |
| Maven | 3.6+ | Build and dependency management |
| Git | Latest | Version control |
| IDE (Optional) | IntelliJ/Eclipse | Development |

### System Requirements

- **RAM**: Minimum 4GB, Recommended 8GB
- **Disk Space**: 2GB free space
- **Network**: Internet connection for external API calls

## 🌍 Environment Setup

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/karate-api-automation.git
cd karate-api-automation
```

### 2. Verify Java Installation

```bash
java -version
# Expected output: openjdk version "11.x.x"
```

### 3. Verify Maven Installation

```bash
mvn -version
# Expected output: Apache Maven 3.x.x
```

### 4. Install Dependencies

```bash
mvn clean install
```

### 5. Environment Configuration

The framework supports multiple environments through `karate-config.js`:

```bash
# Development (default)
mvn test -Dkarate.env=dev

# Staging
mvn test -Dkarate.env=staging

# Production
mvn test -Dkarate.env=prod

# Mock server
mvn test -Dkarate.env=mock
```

## 🚀 Running Tests

### Basic Test Execution

```bash
# Run all tests
mvn test

# Run with verbose output
mvn test -Dkarate.options="--verbose"

# Run specific feature file
mvn test -Dkarate.options="classpath:features/authentication/login.feature"
```

### Tag-Based Execution

```bash
# Run smoke tests only
mvn test -Dkarate.options="--tags @smoke"

# Run regression tests only
mvn test -Dkarate.options="--tags @regression"

# Run performance tests only
mvn test -Dkarate.options="--tags @performance"

# Run specific combination
mvn test -Dkarate.options="--tags @smoke and @regression"

# Exclude specific tags
mvn test -Dkarate.options="--tags ~@ignore"
```

### Parallel Execution

```bash
# Run tests in parallel (default: 4 threads)
mvn test -Dkarate.options="--threads 4"

# Run specific features in parallel
mvn test -Dkarate.options="classpath:features/authentication --threads 2"
```

## 📂 Test Categories

### 1. Authentication Tests

**Location**: `src/test/java/features/authentication/`

**Execution**:
```bash
# All authentication tests
mvn test -Dkarate.options="classpath:features/authentication"

# Specific authentication test
mvn test -Dkarate.options="classpath:features/authentication/login.feature"
```

**Coverage**:
- ✅ User login (valid/invalid credentials)
- ✅ Token generation and validation
- ✅ User registration
- ✅ Password policies
- ✅ Session management

### 2. Product Catalog Tests

**Location**: `src/test/java/features/product-catalog/`

**Execution**:
```bash
# All product catalog tests
mvn test -Dkarate.options="classpath:features/product-catalog"

# Product search tests
mvn test -Dkarate.options="classpath:features/product-catalog/product-search.feature"
```

**Coverage**:
- ✅ Product listing and pagination
- ✅ Search and filtering
- ✅ Product details
- ✅ Category management
- ✅ Product CRUD (admin)

### 3. Shopping Cart Tests

**Location**: `src/test/java/features/shopping-cart/`

**Execution**:
```bash
# All shopping cart tests
mvn test -Dkarate.options="classpath:features/shopping-cart"

# Cart operations tests
mvn test -Dkarate.options="classpath:features/shopping-cart/cart-operations.feature"
```

**Coverage**:
- ✅ Add/update/remove items
- ✅ Cart validation
- ✅ Inventory checks
- ✅ Discount application
- ✅ Cart persistence

### 4. Checkout & Order Tests

**Location**: `src/test/java/features/checkout-orders/`

**Execution**:
```bash
# All checkout and order tests
mvn test -Dkarate.options="classpath:features/checkout-orders"

# Checkout process tests
mvn test -Dkarate.options="classpath:features/checkout-orders/checkout-process.feature"
```

**Coverage**:
- ✅ Complete checkout flow
- ✅ Payment processing
- ✅ Order creation
- ✅ Order tracking
- ✅ Refund processing

## ⚡ Performance Testing

### Performance Test Execution

```bash
# Run all performance tests
mvn gatling:test -Pperformance

# Run specific performance test
mvn gatling:test -Pperformance \
  -Dgatling.simulationClass=performance.CartPerformanceTest

# Run with custom parameters
mvn gatling:test -Pperformance \
  -Dusers=100 \
  -Dduration=60
```

### Performance Test Suites

| Test Class | Description | Default Users | Duration |
|------------|-------------|---------------|----------|
| AuthenticationPerformanceTest | Login and auth operations | 20 | 2 min |
| ProductCatalogPerformanceTest | Product search and catalog | 50 | 3 min |
| CartPerformanceTest | Shopping cart operations | 5 | 2 min |
| CheckoutPerformanceTest | Checkout and order processing | 5 | 2 min |

### Performance Reports

After running performance tests, reports are generated in:
```
target/gatling/
├── gatling-<simulation>-<timestamp>/
│   ├── index.html
│   ├── js/
│   └── style/
```

## 📊 Test Reports

### HTML Reports

```bash
# Generate HTML reports
mvn karate:report

# View reports
open target/karate-reports/karate-summary.html
```

### Report Locations

| Report Type | Location | Description |
|-------------|----------|-------------|
| Karate HTML | `target/karate-reports/` | Interactive test results |
| Surefire XML | `target/surefire-reports/` | JUnit-compatible results |
| Gatling HTML | `target/gatling/` | Performance test results |
| Coverage | `target/site/jacoco/` | Code coverage reports |

## 🐛 Troubleshooting

### Common Issues

#### 1. Java Version Incompatibility

**Problem**: `UnsupportedClassVersionError`

**Solution**:
```bash
# Check Java version
java -version

# Set JAVA_HOME to Java 11
export JAVA_HOME=/path/to/java11
```

#### 2. Maven Dependency Issues

**Problem**: `Could not find artifact`

**Solution**:
```bash
# Clean and rebuild
mvn clean install -U

# Clear Maven cache
mvn dependency:purge-local-repository
```

#### 3. Test Data Issues

**Problem**: Tests failing due to missing test data

**Solution**:
```bash
# Verify API endpoints are accessible
curl -I https://fakestoreapi.com/products

# Check test data configuration
cat src/test/java/karate-config.js
```

#### 4. Performance Test Failures

**Problem**: OutOfMemoryError during performance tests

**Solution**:
```bash
# Increase heap size
export MAVEN_OPTS="-Xmx4g -Xms2g"

# Run with fewer concurrent users
mvn gatling:test -Pperformance -Dusers=10
```

### Debug Mode

```bash
# Run tests in debug mode
mvn test -Dkarate.options="--debug"

# Run specific test in debug mode
mvn test -Dkarate.options="classpath:features/authentication/login.feature --debug"
```

### Log Analysis

```bash
# View test logs
tail -f target/karate-reports/karate.log

# Filter specific test logs
grep "Authentication" target/karate-reports/karate.log
```

## 🎯 Best Practices

### 1. Test Organization

- **Feature Files**: Organize by functionality
- **Tags**: Use consistent tagging strategy
- **Common Functions**: Reuse utilities from `common.feature`
- **Test Data**: Externalize test data configuration

### 2. Execution Strategy

- **Smoke Tests**: Run on every commit
- **Regression Tests**: Run daily or before releases
- **Performance Tests**: Run weekly or on demand
- **Integration Tests**: Run with real APIs

### 3. CI/CD Integration

```bash
# Local testing before push
mvn test -Dkarate.options="--tags @smoke"

# Full test suite before PR
mvn test -Dkarate.options="--tags @smoke and @regression"
```

### 4. Performance Testing Guidelines

- **Baseline**: Establish performance baselines
- **Thresholds**: Define acceptable response times
- **Monitoring**: Track performance trends
- **Environment**: Use production-like environments

### 5. Error Handling

- **Assertions**: Use meaningful assertions
- **Error Messages**: Provide clear error descriptions
- **Retry Logic**: Implement retry for flaky tests
- **Logging**: Log important test events

## 📞 Getting Help

### Resources

- **Karate Documentation**: https://github.com/intuit/karate
- **Gatling Documentation**: https://gatling.io/docs/
- **Project Wiki**: [GitHub Wiki](https://github.com/your-username/karate-api-automation/wiki)

### Support Channels

- **Issues**: [GitHub Issues](https://github.com/your-username/karate-api-automation/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-username/karate-api-automation/discussions)
- **Email**: your-email@example.com

### Contributing

1. **Fork** the repository
2. **Create** a feature branch
3. **Add** tests for new functionality
4. **Ensure** all tests pass
5. **Submit** a pull request

---

**Happy Testing! 🎉**
