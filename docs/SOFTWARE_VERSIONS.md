# Software Versions Guide

This document provides detailed version requirements and compatibility information for the E-commerce API Test Automation Suite.

**Author**: Divya.V, II MSc Computer Science, Gobi Arts and Science College (Autonomous), Gobichettipalayam, Erode District, Pin 638458

---

## 🎯 Quick Version Summary

| Software | Minimum | Recommended | Latest | Status |
|----------|---------|-------------|--------|--------|
| **Java** | 11 (LTS) | 17 (LTS) | 21 (LTS) | ✅ Required |
| **Maven** | 3.6.3 | 3.9.6 | 3.9.7 | ✅ Required |
| **Git** | 2.20.0 | 2.40.0 | 2.43.0 | ✅ Required |
| **IDE** | Any | IntelliJ 2023.3 | Latest | ⭐ Recommended |
| **Browser** | Any | Chrome 120+ | Latest | ⭐ Recommended |

---

## ☕ Java Development Kit (JDK)

### **Supported Versions**
```
✅ Java 11 (LTS) - Minimum Required
   - Long-term support until 2026
   - Stable and widely adopted
   - Good compatibility with Karate

✅ Java 17 (LTS) - Recommended
   - Long-term support until 2029
   - Better performance
   - Latest features
   - Best choice for new projects

✅ Java 21 (LTS) - Latest
   - Long-term support until 2031
   - Newest features
   - Excellent performance
   - Fully compatible
```

### **Installation Commands**

#### **Windows**
```powershell
# Download from: https://adoptium.net/temurin/releases/?version=17
# Run installer and follow setup wizard

# Verify installation:
java -version
javac -version

# Set JAVA_HOME (if needed):
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.x.x-hotspot
```

#### **macOS**
```bash
# Using Homebrew:
brew install openjdk@17

# Set JAVA_HOME:
export JAVA_HOME=/usr/local/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home

# Verify:
java -version
```

#### **Linux**
```bash
# Ubuntu/Debian:
sudo apt update
sudo apt install openjdk-17-jdk

# Verify:
java -version
```

---

## 🔨 Apache Maven

### **Supported Versions**
```
✅ Maven 3.6.3 - Minimum Required
   - Basic features
   - Stable performance
   - Compatible with Java 11+

✅ Maven 3.8.8 - Stable
   - Improved dependency resolution
   - Better performance
   - Good middle ground

✅ Maven 3.9.6 - Recommended
   - Latest stable version
   - Best performance
   - Enhanced security
   - Full feature set

✅ Maven 3.9.7 - Latest
   - Latest bug fixes
   - Minor improvements
   - Also compatible
```

### **Installation Commands**

#### **Windows**
```powershell
# Download from: https://maven.apache.org/download.cgi
# Extract to: C:\Program Files\Apache\maven\apache-maven-3.9.6

# Set environment variables:
set MAVEN_HOME=C:\Program Files\Apache\maven\apache-maven-3.9.6
set PATH=%PATH%;%MAVEN_HOME%\bin

# Verify:
mvn --version
```

#### **macOS**
```bash
# Using Homebrew:
brew install maven

# Verify:
mvn --version
```

#### **Linux**
```bash
# Ubuntu/Debian:
sudo apt install maven

# Or download latest version:
wget https://archive.apache.org/dist/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
sudo tar xf apache-maven-3.9.6-bin.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.9.6 /opt/maven

# Verify:
mvn --version
```

---

## 📦 Git

### **Supported Versions**
```
✅ Git 2.20.0 - Minimum Required
   - Basic features
   - Stable performance
   - Compatible with all platforms

✅ Git 2.30.0 - Stable
   - Improved performance
   - Better merge capabilities
   - Good security updates

✅ Git 2.40.0 - Recommended
   - Excellent performance
   - Latest features
   - Best security

✅ Git 2.43.0 - Latest
   - Newest features
   - Latest security patches
   - Minor improvements
```

### **Installation Commands**

#### **Windows**
```powershell
# Download from: https://git-scm.com/download/win
# Run installer with default options

# Verify:
git --version
```

#### **macOS**
```bash
# Using Homebrew:
brew install git

# Or Xcode Command Line Tools:
xcode-select --install

# Verify:
git --version
```

#### **Linux**
```bash
# Ubuntu/Debian:
sudo apt update
sudo apt install git

# Verify:
git --version
```

---

## 🛠️ Development Environment

### **IntelliJ IDEA (Recommended)**

#### **Supported Versions**
```
✅ IntelliJ IDEA 2022.3 - Minimum
   - Basic Karate support
   - Maven integration
   - Git integration

✅ IntelliJ IDEA 2023.2 - Good
   - Better Karate plugin
   - Improved Maven support
   - Enhanced Git features

✅ IntelliJ IDEA 2023.3 - Recommended
   - Latest features
   - Best performance
   - Excellent plugin support
   - Full integration

✅ IntelliJ IDEA 2024.1 - Latest
   - Newest features
   - Latest improvements
   - Also compatible
```

#### **Required Plugins**
```
✅ Karate Plugin - For .feature file support
✅ Maven Plugin - For dependency management
✅ Git Integration - For version control
✅ Terminal Plugin - For command line access
```

### **Eclipse IDE (Alternative)**

#### **Supported Versions**
```
✅ Eclipse 2022-12 - Minimum
   - Basic Java support
   - Maven integration
   - EGit plugin

✅ Eclipse 2023-06 - Good
   - Better performance
   - Improved Maven support
   - Enhanced Git features

✅ Eclipse 2023-12 - Recommended
   - Latest stable version
   - Best performance
   - Full feature set
```

---

## 🌐 Browser Versions

### **For Report Viewing**

#### **Google Chrome (Recommended)**
```
✅ Chrome 120+ - Minimum
   - Best HTML report rendering
   - Excellent JavaScript performance
   - Good developer tools

✅ Chrome 121+ - Recommended
   - Latest security updates
   - Best performance
   - Full compatibility
```

#### **Mozilla Firefox**
```
✅ Firefox 121+ - Minimum
   - Good HTML report support
   - Excellent developer tools
   - Cross-platform compatibility

✅ Firefox 122+ - Recommended
   - Latest features
   - Best performance
   - Enhanced security
```

#### **Microsoft Edge**
```
✅ Edge 120+ - Minimum
   - Built-in with Windows 11
   - Good compatibility
   - Decent performance

✅ Edge 121+ - Recommended
   - Latest features
   - Better performance
   - Enhanced security
```

---

## 📊 Project Framework Versions

### **Karate Framework**
```
Version Used: 1.4.0
Release Date: November 2023
Compatibility: Java 11+
Features:
  - BDD-style testing
  - API testing capabilities
  - Performance testing integration
  - Excellent reporting
```

### **JUnit**
```
Version Used: 5.10.0
Release Date: September 2023
Compatibility: Java 8+
Features:
  - Modern testing framework
  - Excellent Karate integration
  - Parameterized tests
  - Advanced assertions
```

### **Gatling**
```
Version Used: 3.9.5
Release Date: October 2023
Compatibility: Java 11+
Features:
  - Performance testing
  - Load simulation
  - Detailed reports
  - Karate integration
```

---

## 🔍 Version Verification Script

### **Windows Batch Script**
```batch
@echo off
echo Checking Software Versions...
echo ============================

echo Java:
java -version

echo.
echo Maven:
mvn --version

echo.
echo Git:
git --version

echo.
echo All versions checked successfully!
pause
```

### **PowerShell Script**
```powershell
Write-Host "Checking Software Versions..." -ForegroundColor Green
Write-Host "============================" -ForegroundColor Green

Write-Host "`nJava:" -ForegroundColor Yellow
java -version

Write-Host "`nMaven:" -ForegroundColor Yellow
mvn --version

Write-Host "`nGit:" -ForegroundColor Yellow
git --version

Write-Host "`nAll versions checked successfully!" -ForegroundColor Green
```

---

## 🚨 Common Version Issues

### **Java Version Issues**
```
Problem: "Unsupported class file version"
Solution: Upgrade to Java 11 or higher

Problem: "JAVA_HOME not set"
Solution: Set JAVA_HOME environment variable

Problem: "Java not found in PATH"
Solution: Add Java bin directory to PATH
```

### **Maven Version Issues**
```
Problem: "Maven not recognized"
Solution: Add Maven bin directory to PATH

Problem: "MAVEN_HOME not set"
Solution: Set MAVEN_HOME environment variable

Problem: "Maven build failures"
Solution: Check Maven version compatibility
```

### **Git Version Issues**
```
Problem: "Git not recognized"
Solution: Add Git to PATH during installation

Problem: "SSL certificate issues"
Solution: Update Git or configure SSL settings

Problem: "Authentication failures"
Solution: Configure Git credentials
```

---

## 📈 Version Upgrade Path

### **Recommended Upgrade Sequence**
```
1. Install/Upgrade Java to 17 LTS
2. Install/Upgrade Maven to 3.9.6
3. Install/Upgrade Git to 2.40.0
4. Install/Upgrade IDE to latest version
5. Verify all installations
6. Clone and test project
```

### **Upgrade Benefits**
```
✅ Better Performance
✅ Enhanced Security
✅ Latest Features
✅ Bug Fixes
✅ Improved Compatibility
✅ Better Developer Experience
```

---

## 🎯 Testing Your Setup

### **Quick Test Commands**
```bash
# Test Java
java -version

# Test Maven
mvn --version

# Test Git
git --version

# Clone and test project
git clone https://github.com/your-username/karate-api-automation.git
cd karate-api-automation
mvn clean test
```

### **Expected Results**
```
✅ Java version 11+ displayed
✅ Maven version 3.6+ displayed
✅ Git version 2.20+ displayed
✅ Project builds successfully
✅ Tests run without errors
✅ Reports generated correctly
```

---

## 📞 Support and Help

### **Official Documentation**
- **Java**: https://docs.oracle.com/en/java/
- **Maven**: https://maven.apache.org/docs/
- **Git**: https://git-scm.com/doc
- **Karate**: https://github.com/intuit/karate

### **Community Support**
- **Stack Overflow**: Search for specific version issues
- **GitHub Issues**: Report framework-specific problems
- **Reddit**: r/java, r/devops for general help

---

**Prepared by**: Divya.V, II MSc Computer Science  
**Institution**: Gobi Arts and Science College (Autonomous)  
**Date**: March 8, 2026  
**Last Updated**: Software versions as of March 2026

*This guide provides comprehensive version information for setting up the development environment for the E-commerce API Test Automation Suite.*
