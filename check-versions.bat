@echo off
echo 🔍 Checking Software Versions for Karate Project
echo =============================================

echo.
echo ☕ Java Version:
java -version
if %errorlevel% equ 0 (
    echo ✅ Java is installed
) else (
    echo ❌ Java not found - Please install Java 11 or higher
)

echo.
echo 🔨 Maven Version:
mvn --version
if %errorlevel% equ 0 (
    echo ✅ Maven is installed
) else (
    echo ❌ Maven not found - Please install Maven 3.6 or higher
)

echo.
echo 📦 Git Version:
git --version
if %errorlevel% equ 0 (
    echo ✅ Git is installed
) else (
    echo ❌ Git not found - Please install Git 2.20 or higher
)

echo.
echo 📋 Version Requirements:
echo    Java: 11+ (Recommended: 17 LTS)
echo    Maven: 3.6+ (Recommended: 3.9.6)
echo    Git: 2.20+ (Recommended: 2.40+)

echo.
echo 🎯 Project Versions:
echo    Karate: 1.4.0
echo    JUnit: 5.10.0
echo    Gatling: 3.9.5

echo.
echo 📚 Download Links:
echo    Java: https://adoptium.net/
echo    Maven: https://maven.apache.org/download.cgi
echo    Git: https://git-scm.com/

pause
