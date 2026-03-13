@echo off
echo 🚀 Running Product Search Tests
echo ================================

cd /d "c:/Users/Suresh Kumar PR/Documents/Divya_Project"

echo 📋 Available Options:
echo 1. Run all product search tests
echo 2. Run specific search scenario
echo 3. Run all product catalog tests
echo 4. Run smoke tests
echo 5. Run full test suite
echo.

set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" (
    echo 🔍 Running all product search tests...
    mvn test -Dkarate.options="classpath:features/product-catalog/product-search.feature"
) else if "%choice%"=="2" (
    echo 🎯 Running specific search scenario...
    mvn test -Dkarate.options="classpath:features/product-catalog/product-search.feature@Search products by keyword"
) else if "%choice%"=="3" (
    echo 🛍️ Running all product catalog tests...
    mvn test -Dkarate.options="classpath:features/product-catalog"
) else if "%choice%"=="4" (
    echo 💨 Running smoke tests...
    mvn test -Dkarate.options="--tags @smoke"
) else if "%choice%"=="5" (
    echo 🎯 Running full test suite...
    mvn clean test
) else (
    echo ❌ Invalid choice. Please run again.
    goto :end
)

echo.
echo 📊 Generating reports...
mvn karate:report

echo.
echo 🎯 Opening test report...
start "" "target/karate-reports/karate-summary.html"

:end
echo.
echo ✅ Test execution completed!
pause
