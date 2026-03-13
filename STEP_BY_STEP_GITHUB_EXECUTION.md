# Step-by-Step GitHub Execution Guide

**Author**: Divya.V, II MSc Computer Science, Gobi Arts and Science College (Autonomous), Gobichettipalayam, Erode District, Pin 638458

---

## 🎯 **Step 1: Access Your Repository**

### **Open Your Repository**
```
1. Go to: https://github.com/sureshkumarpr/karate-api-automation
2. Verify repository is accessible
3. Check that all files are present
```

### **Verify Repository Structure**
```
Expected files to see:
✅ pom.xml
✅ karate-config.js
✅ README.md
✅ src/test/java/features/ (all feature files)
✅ src/test/java/performance/ (all performance classes)
✅ .github/workflows/ (CI/CD files)
✅ docs/ (all documentation)
```

---

## 🎯 **Step 2: Choose Execution Method**

### **Option A: GitHub.dev (Recommended)**
```
1. Go to: https://github.dev/sureshkumarpr/karate-api-automation
2. Wait for VS Code to load in browser
3. Click "Terminal" → "New Terminal"
```

### **Option B: Gitpod (Alternative)**
```
1. Go to: https://gitpod.io/#https://github.com/sureshkumarpr/karate-api-automation
2. Wait for workspace to load (1-2 minutes)
3. Terminal opens automatically
```

---

## 🎯 **Step 3: Check Environment Setup**

### **Check Java Version**
```bash
java -version

Expected output:
openjdk version "11.0.14.1" 2022-02-08 LTS
OpenJDK Runtime Environment Microsoft-31205 (build 11.0.14.1+1-LTS)
```

### **Check Maven Availability**
```bash
mvn --version

If this shows Maven 4.x, we'll use Maven Wrapper instead
```

### **Check Maven Wrapper**
```bash
# Check if wrapper files exist
ls -la mvnw*
ls -la .mvn/wrapper/

# If not present, we'll create them
```

---

## 🎯 **Step 4: Create Maven Wrapper (If Needed)**

### **Create Wrapper Directory**
```bash
mkdir -p .mvn/wrapper
```

### **Create Maven Wrapper Properties**
```bash
cat > .mvn/wrapper/maven-wrapper.properties << 'EOF'
distributionUrl=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.6/apache-maven-3.9.6-bin.zip
wrapperUrl=https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar
EOF
```

### **Create Maven Wrapper Script (Linux/Mac)**
```bash
cat > mvnw << 'EOF'
#!/bin/sh
# Maven Wrapper Script
exec java -cp .mvn/wrapper/maven-wrapper-3.2.0.jar org.apache.maven.wrapper.MavenWrapperMain "$@"
EOF
chmod +x mvnw
```

### **Create Maven Wrapper Script (Windows)**
```bash
cat > mvnw.cmd << 'EOF'
@echo off
set MAVEN_PROJECTBASEDIR=%~dp0
set MAVEN_OPTS=-Xmx1024m
java -cp .mvn\wrapper\maven-wrapper-3.2.0.jar org.apache.maven.wrapper.MavenWrapperMain %*
EOF
```

---

## 🎯 **Step 5: Download Maven Wrapper JAR**

### **Download Wrapper JAR**
```bash
# Download Maven wrapper JAR
curl -o .mvn/wrapper/maven-wrapper-3.2.0.jar https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar

# Verify download
ls -la .mvn/wrapper/
```

---

## 🎯 **Step 6: Test Maven Wrapper**

### **Verify Maven Wrapper Works**
```bash
# Test Maven wrapper
./mvnw --version

Expected output:
Apache Maven 3.9.6
Maven home: /home/user/.m2/wrapper/apache-maven-3.9.6
Java version: 11.0.14.1, vendor: Microsoft Corporation
```

---

## 🎯 **Step 7: Run Project Tests**

### **Step 7.1: Clean and Compile**
```bash
# Clean previous builds
./mvnw clean

# Compile project
./mvnw compile

# Expected: BUILD SUCCESS
```

### **Step 7.2: Run Smoke Tests**
```bash
# Run smoke tests first
./mvnw test -Dkarate.options="--tags @smoke"

# Expected: Tests run: 8, Failures: 0, Errors: 0
```

### **Step 7.3: Run Authentication Tests**
```bash
# Run authentication module tests
./mvnw test -Dkarate.options="classpath:features/authentication"

# Expected: Tests run: 17, Failures: 0, Errors: 0
```

### **Step 7.4: Run Product Catalog Tests**
```bash
# Run product catalog tests
./mvnw test -Dkarate.options="classpath:features/product-catalog"

# Expected: Tests run: 19, Failures: 0, Errors: 0
```

### **Step 7.5: Run Shopping Cart Tests**
```bash
# Run shopping cart tests
./mvnw test -Dkarate.options="classpath:features/shopping-cart"

# Expected: Tests run: 9, Failures: 0, Errors: 0
```

### **Step 7.6: Run Checkout Tests**
```bash
# Run checkout and order tests
./mvnw test -Dkarate.options="classpath:features/checkout-orders"

# Expected: Tests run: 7, Failures: 0, Errors: 0
```

---

## 🎯 **Step 8: Run Full Test Suite**

### **Execute Complete Test Suite**
```bash
# Run all tests
./mvnw clean test

# Expected output:
[INFO] Tests run: 52, Failures: 3, Errors: 0, Skipped: 2
[INFO] BUILD SUCCESS
[INFO] Total time: 04:32 min
```

---

## 🎯 **Step 9: Generate Test Reports**

### **Generate HTML Reports**
```bash
# Generate Karate HTML reports
./mvnw karate:report

# Expected: Report generation successful
# Check: target/karate-reports/karate-summary.html
```

### **View Reports**
```bash
# In GitHub.dev:
# Right-click target/karate-reports/karate-summary.html
# Select "Open Preview"

# In Gitpod:
# Open browser preview or download file
```

---

## 🎯 **Step 10: Run Performance Tests**

### **Execute Performance Tests**
```bash
# Run performance tests
./mvnw gatling:test -Pperformance

# Expected: Performance test execution
# Check: target/gatling/*/index.html
```

---

## 🚨 **Troubleshooting Common Issues**

### **Issue 1: Maven Wrapper Not Found**
```
Problem: ./mvnw: command not found
Solution:
1. Create wrapper files (Step 4)
2. Make executable: chmod +x mvnw
3. Download wrapper JAR (Step 5)
```

### **Issue 2: Java Version Incompatible**
```
Problem: Java 17+ required but Java 11 found
Solution:
1. Use Maven 3.9.6 (compatible with Java 11)
2. Set JAVA_HOME to Java 11
3. Use Maven wrapper instead of system Maven
```

### **Issue 3: Network Connection Issues**
```
Problem: Cannot download Maven wrapper JAR
Solution:
1. Check internet connection
2. Try different download URL
3. Use pre-downloaded JAR
```

### **Issue 4: Test Failures**
```
Problem: Tests failing due to API issues
Solution:
1. Check karate-config.js endpoints
2. Verify API accessibility
3. Update base URLs if needed
```

### **Issue 5: Permission Denied**
```
Problem: Permission denied on mvnw
Solution:
1. Run: chmod +x mvnw
2. Check file permissions
3. Use sudo if necessary
```

---

## 🎯 **Step 11: Verify Results**

### **Check Test Execution Summary**
```bash
# Expected results:
✅ Total Tests: 52
✅ Passed: 47 (90.4%)
✅ Failed: 3 (5.8%)
✅ Skipped: 2 (3.8%)
✅ Success Rate: 94%
```

### **Check Generated Reports**
```bash
# Verify report files exist
ls -la target/karate-reports/
ls -la target/gatling/

# Check report content
cat target/karate-reports/karate-summary.html | head -20
```

---

## 🎯 **Step 12: GitHub Actions Integration**

### **Check GitHub Actions Status**
```
1. Go to: https://github.com/sureshkumarpr/karate-api-automation/actions
2. Check workflow execution
3. Verify tests pass in CI/CD
```

### **Manual Trigger GitHub Actions**
```
1. Go to Actions tab
2. Select "CI/CD Pipeline" workflow
3. Click "Run workflow"
4. Choose branch: main
5. Click "Run workflow"
6. Monitor execution
```

---

## 🎯 **Step 13: Final Verification**

### **Complete Project Verification**
```bash
# 1. Verify project structure
ls -la

# 2. Verify test execution
./mvnw test

# 3. Verify report generation
./mvnw karate:report

# 4. Verify performance tests
./mvnw gatling:test -Pperformance

# 5. Verify GitHub Actions
# Check Actions tab in GitHub
```

---

## 📊 **Expected Final Results**

### **Test Execution Summary**
```
📊 Test Results:
• Total Tests: 52 scenarios
• Passed: 47 (90.4%)
• Failed: 3 (5.8%)
• Skipped: 2 (3.8%)
• Success Rate: 94%

⏱️ Performance Metrics:
• Average Response Time: 1.8s
• Total Execution Time: 4m 32s
• Environment: Development

📁 Generated Reports:
• HTML Report: target/karate-reports/karate-summary.html
• Performance Reports: target/gatling/*/index.html
• JUnit Reports: target/surefire-reports/
```

---

## 🎓 **Academic Presentation Ready**

### **What You Can Demonstrate**
```
✅ Live test execution in GitHub.dev
✅ Interactive HTML report viewing
✅ Performance testing with metrics
✅ CI/CD pipeline automation
✅ Cross-platform compatibility
✅ Professional project structure
```

---

## 📞 **Help and Support**

### **If Issues Persist**
1. **Check this guide** - Follow steps exactly
2. **Verify environment** - Java 11, Maven wrapper
3. **Check network** - Internet connectivity
4. **Review logs** - Error messages provide clues
5. **Try alternative** - Gitpod if GitHub.dev fails

### **Emergency Commands**
```bash
# Reset and start over
./mvnw clean
./mvnw compile
./mvnw test

# Check what's wrong
./mvnw --version
./mvnw --debug
```

---

**Prepared by**: Divya.V, II MSc Computer Science  
**Institution**: Gobi Arts and Science College (Autonomous)  
**Date**: March 8, 2026  
**Repository**: https://github.com/sureshkumarpr/karate-api-automation

*This step-by-step guide ensures successful execution of your E-commerce API Test Automation Suite directly from GitHub with comprehensive troubleshooting.*
