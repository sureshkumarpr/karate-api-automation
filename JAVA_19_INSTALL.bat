@echo off
title Java 19 Setup - Karate Test Automation
color 0A

echo ========================================
echo   Java 19 Setup - Karate Test Automation
echo ========================================
echo.

echo ✅ Java 19 Detected - Excellent for Karate!
echo Karate requires Java 11+, you have Java 19
echo.

echo SETUP OPTIONS:
echo ================
echo.
echo A. VIEW REPORTS ONLY (Recommended)
echo    Software: Web browser only
echo    Java: Not needed
echo    Time: 2 minutes
echo.
echo B. RUN KARATE TESTS LOCALLY
echo    Software: Maven + Git + Java 19
echo    Java: Already installed (Java 19)
echo    Time: 5 minutes
echo.
echo C. FULL DEVELOPMENT SETUP
echo    Software: Maven + Git + Node.js + Java 19
echo    Purpose: Run tests + host reports
echo    Time: 10 minutes
echo.
echo X. EXIT
echo.

set /p choice="Select option (A/B/C/X): "

if /i "%choice%"=="A" goto VIEW_ONLY
if /i "%choice%"=="B" goto RUN_TESTS
if /i "%choice%"=="C" goto FULL_SETUP
if /i "%choice%"=="X" goto END

:VIEW_ONLY
echo.
echo ========================================
echo   VIEW REPORTS ONLY
echo ========================================
echo.
echo Perfect! No additional software needed.
echo.
echo Your manager can access reports at:
echo https://sureshkumarpr.github.io/karate-api-automation/karate-summary.html
echo.
echo Instructions:
echo 1. Open web browser
echo 2. Go to URL above
echo 3. Bookmark for future access
echo.
echo Benefits:
echo ✅ Instant access
echo ✅ No installation
echo ✅ Works from any device
echo ✅ Always latest report
echo.
goto END

:RUN_TESTS
echo.
echo ========================================
echo   RUN KARATE TESTS LOCALLY
echo ========================================
echo.
echo Since you have Java 19, you just need Maven and Git.
echo.

REM Download Maven
echo Downloading Maven 3.9.6 (8.5MB)...
curl -L "https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip" -o "%USERPROFILE%\Desktop\apache-maven-3.9.6-bin.zip"

REM Download Git
echo Downloading Git 2.44.0 (50MB)...
curl -L "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe" -o "%USERPROFILE%\Desktop\Git-2.44.0-64-bit.exe"

echo.
echo Downloads completed! Files saved to Desktop:
echo - apache-maven-3.9.6-bin.zip
echo - Git-2.44.0-64-bit.exe
echo.
echo Installation Instructions:
echo.
echo 1. INSTALL GIT:
echo    - Run Git-2.44.0-64-bit.exe
echo    - Use default settings
echo    - Restart Command Prompt
echo.
echo 2. INSTALL MAVEN:
echo    - Extract apache-maven-3.9.6-bin.zip to C:\Program Files\Apache\Maven\
echo    - Add to PATH: C:\Program Files\Apache\Maven\apache-maven-3.9.6\bin
echo    - Restart Command Prompt
echo.
echo 3. VERIFY INSTALLATION:
echo    git --version
echo    mvn -version
echo    java -version
echo.
echo 4. RUN KARATE TESTS:
echo    git clone https://github.com/sureshkumarpr/karate-api-automation.git
echo    cd karate-api-automation
echo    mvn test
echo.
goto END

:FULL_SETUP
echo.
echo ========================================
echo   FULL DEVELOPMENT SETUP
echo ========================================
echo.
echo Setting up complete environment with Java 19...
echo.

REM Create setup directory
if not exist "%USERPROFILE%\Downloads\KarateSetup" mkdir "%USERPROFILE%\Downloads\KarateSetup"

REM Download Maven
echo Downloading Maven...
curl -L "https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip" -o "%USERPROFILE%\Downloads\KarateSetup\apache-maven-3.9.6-bin.zip"

REM Download Git
echo Downloading Git...
curl -L "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe" -o "%USERPROFILE%\Downloads\KarateSetup\Git-2.44.0-64-bit.exe"

REM Download Node.js
echo Downloading Node.js...
curl -L "https://nodejs.org/dist/v20.11.1/node-v20.11.1-x64.msi" -o "%USERPROFILE%\Downloads\KarateSetup\node-v20.11.1-x64.msi"

echo.
echo Downloads completed!
echo Files saved to: %USERPROFILE%\Downloads\KarateSetup\
echo.
echo Installation Order:
echo 1. Git-2.44.0-64-bit.exe
echo 2. Extract apache-maven-3.9.6-bin.zip to C:\Program Files\Apache\Maven\
echo 3. node-v20.11.1-x64.msi
echo 4. Restart computer
echo.
echo After installation, run:
echo git clone https://github.com/sureshkumarpr/karate-api-automation.git
echo cd karate-api-automation
echo mvn test
echo.

:END
echo.
echo ========================================
echo   Java 19 Setup Complete!
echo ========================================
echo.
echo Your Java 19 is perfect for Karate!
echo.
echo Quick Links:
echo - Report URL: https://sureshkumarpr.github.io/karate-api-automation/karate-summary.html
echo - Maven: https://maven.apache.org/download.cgi
echo - Git: https://git-scm.com/download/win
echo.
echo For detailed instructions: JAVA_19_SETUP_GUIDE.md
echo.
pause
