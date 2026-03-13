@echo off
title Fix GitHub 404 Error
color 0C

echo ========================================
echo   Fix GitHub 404 Error
echo ========================================
echo.

echo Problem: 404 error on GitHub Pages
echo Solution: Enable GitHub Pages in repository settings
echo.

echo Opening GitHub repository settings...
echo.

REM Open GitHub Pages settings in browser
start https://github.com/sureshkumarpr/karate-api-automation/settings/pages

echo ========================================
echo   GitHub Pages Setup Instructions
echo ========================================
echo.
echo 1. In the opened browser window:
echo    - Go to "Pages" section in repository settings
echo    - Source: Select "Deploy from a branch"
echo    - Branch: Select "main"
echo    - Folder: Select "/ (root)"
echo    - Click "Save"
echo.
echo 2. Wait 2-5 minutes for deployment
echo    - GitHub will build and deploy your site
echo    - Check the Actions tab for progress
echo.
echo 3. Test the URL:
echo    - https://sureshkumarpr.github.io/karate-api-automation/
echo    - Should show your karate-summary.html file
echo.
echo 4. If still 404:
echo    - Check that karate-summary.html is in repository
echo    - Verify branch is "main" not "master"
echo    - Try accessing: https://sureshkumarpr.github.io/karate-api-automation/karate-summary.html
echo.

echo ========================================
echo   Alternative: Deploy to Netlify (Faster)
echo ========================================
echo.
echo If GitHub Pages continues to fail:
echo 1. Drag and drop karate-summary.html to: https://app.netlify.com/drop
echo 2. Get instant URL: https://random-name.netlify.app
echo 3. Share that URL with your manager
echo.

echo ========================================
echo   Current Status Check
echo ========================================
echo.

REM Check if git is available
git --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Git not installed. Installing Git first...
    start https://git-scm.com/download/win
    echo.
    echo Please install Git, then run this script again.
    pause
    exit /b 1
)

cd /d "C:\Users\Suresh Kumar PR\Documents\Divya_Project"

REM Check if we're in a git repository
if not exist ".git" (
    echo 📋 Initializing Git repository...
    git init
    git add .
    git commit -m "Initial commit - Karate API Test Report"
    git branch -M main
    git remote add origin https://github.com/sureshkumarpr/karate-api-automation.git
    echo ✅ Git repository initialized
) else (
    echo ✅ Git repository already exists
)

REM Push latest report to GitHub
echo 📤 Pushing latest report to GitHub...
git add karate-summary.html
git commit -m "Update test report - %date% %time%"
git push origin main

echo.
echo ✅ Report pushed to GitHub successfully!
echo.
echo Next steps:
echo 1. Enable GitHub Pages (browser should be open)
echo 2. Wait 2-5 minutes for deployment
echo 3. Test: https://sureshkumarpr.github.io/karate-api-automation/karate-summary.html
echo.

pause
