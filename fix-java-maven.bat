@echo off
echo 🔧 Java/Maven Compatibility Fix
echo =================================
echo Author: Divya.V, II MSc Computer Science, Gobi Arts and Science College (Autonomous)
echo.

echo 📋 Current Java Version:
java -version
echo.

echo 📋 Current Maven Version:
mvn --version
echo.

echo 🎯 Problem: Maven 4.x requires Java 17+, but you have Java 11
echo 💡 Solution: Use Maven 3.9.6 (works with Java 11)
echo.

echo 🔍 Option 1: Download Maven 3.9.6 (Recommended)
echo 1. Go to: https://maven.apache.org/download.cgi
echo 2. Download: apache-maven-3.9.6-bin.zip
echo 3. Extract to: C:\Program Files\Apache\maven\apache-maven-3.9.6
echo 4. Run the setup commands below
echo.

echo 🔍 Option 2: Use Windows Package Manager
echo winget install Apache.Maven --version 3.9.6
echo.

echo 🔍 Option 3: Use Chocolatey (if installed)
echo choco install maven --version 3.9.6
echo.

echo 🚀 Quick Setup Commands (Option 1):
echo.
echo set MAVEN_HOME=C:\Program Files\Apache\maven\apache-maven-3.9.6
echo set PATH=%PATH%;%MAVEN_HOME%\bin
echo mvn --version
echo.

echo 🧪 Test Your Project:
echo mvn clean test
echo mvn karate:report
echo.

echo 📞 If you need more help:
echo 1. Download Maven 3.9.6 manually
echo 2. Set environment variables
echo 3. Restart Command Prompt
echo 4. Run your tests
echo.

pause
