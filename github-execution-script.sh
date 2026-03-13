#!/bin/bash

# GitHub Execution Script for E-commerce API Test Automation Suite
# Author: Divya.V, II MSc Computer Science, Gobi Arts and Science College (Autonomous)

echo "🚀 GitHub Execution Script for E-commerce API Test Automation Suite"
echo "=============================================================="
echo "Author: Divya.V, II MSc Computer Science"
echo "Repository: https://github.com/sureshkumarpr/karate-api-automation"
echo ""

# Step 1: Check Environment
echo "📋 Step 1: Checking Environment..."
echo "Java Version:"
java -version
echo ""

echo "Maven Version (if available):"
mvn --version 2>/dev/null || echo "Maven not found - will use Maven Wrapper"
echo ""

# Step 2: Create Maven Wrapper if needed
echo "📋 Step 2: Setting up Maven Wrapper..."
if [ ! -f "mvnw" ]; then
    echo "Creating Maven Wrapper..."
    mkdir -p .mvn/wrapper
    
    # Create wrapper properties
    cat > .mvn/wrapper/maven-wrapper.properties << 'EOF'
distributionUrl=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.6/apache-maven-3.9.6-bin.zip
wrapperUrl=https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar
EOF
    
    # Create wrapper script
    cat > mvnw << 'EOF'
#!/bin/sh
exec java -cp .mvn/wrapper/maven-wrapper-3.2.0.jar org.apache.maven.wrapper.MavenWrapperMain "$@"
EOF
    
    chmod +x mvnw
    echo "✅ Maven Wrapper created"
else
    echo "✅ Maven Wrapper already exists"
fi

# Step 3: Download Maven Wrapper JAR
echo "📋 Step 3: Downloading Maven Wrapper JAR..."
if [ ! -f ".mvn/wrapper/maven-wrapper-3.2.0.jar" ]; then
    echo "Downloading Maven Wrapper JAR..."
    curl -o .mvn/wrapper/maven-wrapper-3.2.0.jar \
        https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar
    echo "✅ Maven Wrapper JAR downloaded"
else
    echo "✅ Maven Wrapper JAR already exists"
fi

# Step 4: Verify Maven Wrapper
echo "📋 Step 4: Verifying Maven Wrapper..."
./mvnw --version
echo ""

# Step 5: Clean and Compile
echo "📋 Step 5: Cleaning and Compiling..."
./mvnw clean compile
if [ $? -eq 0 ]; then
    echo "✅ Clean and compile successful"
else
    echo "❌ Clean and compile failed"
    exit 1
fi

# Step 6: Run Smoke Tests
echo "📋 Step 6: Running Smoke Tests..."
./mvnw test -Dkarate.options="--tags @smoke"
if [ $? -eq 0 ]; then
    echo "✅ Smoke tests passed"
else
    echo "❌ Smoke tests failed"
fi

# Step 7: Run Authentication Tests
echo "📋 Step 7: Running Authentication Tests..."
./mvnw test -Dkarate.options="classpath:features/authentication"
if [ $? -eq 0 ]; then
    echo "✅ Authentication tests passed"
else
    echo "❌ Authentication tests failed"
fi

# Step 8: Run Product Catalog Tests
echo "📋 Step 8: Running Product Catalog Tests..."
./mvnw test -Dkarate.options="classpath:features/product-catalog"
if [ $? -eq 0 ]; then
    echo "✅ Product Catalog tests passed"
else
    echo "❌ Product Catalog tests failed"
fi

# Step 9: Run Shopping Cart Tests
echo "📋 Step 9: Running Shopping Cart Tests..."
./mvnw test -Dkarate.options="classpath:features/shopping-cart"
if [ $? -eq 0 ]; then
    echo "✅ Shopping Cart tests passed"
else
    echo "❌ Shopping Cart tests failed"
fi

# Step 10: Run Checkout Tests
echo "📋 Step 10: Running Checkout Tests..."
./mvnw test -Dkarate.options="classpath:features/checkout-orders"
if [ $? -eq 0 ]; then
    echo "✅ Checkout tests passed"
else
    echo "❌ Checkout tests failed"
fi

# Step 11: Run Full Test Suite
echo "📋 Step 11: Running Full Test Suite..."
./mvnw clean test
if [ $? -eq 0 ]; then
    echo "✅ Full test suite passed"
else
    echo "❌ Full test suite failed"
fi

# Step 12: Generate Reports
echo "📋 Step 12: Generating Reports..."
./mvnw karate:report
if [ $? -eq 0 ]; then
    echo "✅ Reports generated successfully"
    echo "📊 Report location: target/karate-reports/karate-summary.html"
else
    echo "❌ Report generation failed"
fi

# Step 13: Run Performance Tests
echo "📋 Step 13: Running Performance Tests..."
./mvnw gatling:test -Pperformance
if [ $? -eq 0 ]; then
    echo "✅ Performance tests passed"
    echo "📊 Performance report location: target/gatling/*/index.html"
else
    echo "❌ Performance tests failed"
fi

# Step 14: Final Results
echo ""
echo "🎉 Execution Complete!"
echo "===================="
echo "📊 Results Summary:"
echo "• Test Reports: target/karate-reports/karate-summary.html"
echo "• Performance Reports: target/gatling/*/index.html"
echo "• JUnit Reports: target/surefire-reports/"
echo ""
echo "🌐 To view reports:"
echo "• In GitHub.dev: Right-click report file → Open Preview"
echo "• In Gitpod: Use browser preview"
echo "• Download: Right-click → Download"
echo ""
echo "✅ Your E-commerce API Test Automation Suite is ready!"
echo "🎓 Author: Divya.V, II MSc Computer Science"
echo "🏫 Gobi Arts and Science College (Autonomous)"
echo ""
