@echo off
title GitHub Deploy - Karate Report
color 0B

echo ========================================
echo   GitHub Deploy - Karate Report
echo ========================================
echo.

echo This will deploy your report to GitHub Pages
echo and share it with your manager via URL.
echo.

cd /d "C:\Users\Suresh Kumar PR\Documents\Divya_Project"

REM Check if git is available
git --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Git not found. Installing Git...
    echo Please install Git from: https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

REM Check if report exists
if not exist "karate-summary.html" (
    echo ❌ Report file not found. Generating it first...
    call generate-report.bat
)

echo 📋 Repository Information:
echo   Repository: sureshkumarpr/karate-api-automation
echo   GitHub Pages URL: https://sureshkumarpr.github.io/karate-api-automation/
echo.

echo 🔧 Deploying to GitHub...
echo.

REM Initialize git if not already done
if not exist ".git" (
    echo Initializing Git repository...
    git init
    git add .
    git commit -m "Initial commit - Karate API Test Automation"
    git branch -M main
    git remote add origin https://github.com/sureshkumarpr/karate-api-automation.git
)

REM Add and push report
echo Adding report to repository...
git add karate-summary.html
git commit -m "Update test report - %date% %time%"
git push origin main

echo.
echo ✅ Report deployed to GitHub!
echo.
echo 🌐 Share this URL with your manager:
echo    https://sureshkumarpr.github.io/karate-api-automation/karate-summary.html
echo.
echo 📧 Alternative: Send email with URL
echo    Run: email-report.bat
echo.

pause
