@echo off
title Commit Complete Code to Main Branch
color 0A

echo ========================================
echo   Commit Complete Code to Main Branch
echo ========================================
echo.

echo This script will commit all the Karate automation
echo setup files, guides, and scripts to the main branch.
echo.

REM Check if git is available
git --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Git not found. Please install Git first:
    echo    https://git-scm.com/download/win
    echo.
    echo After installing Git, run this script again.
    pause
    exit /b 1
)

cd /d "C:\Users\Suresh Kumar PR\Documents\Divya_Project"

echo STEP 1: INITIALIZE GIT REPOSITORY
echo ================================
echo.

if not exist ".git" (
    echo Initializing Git repository...
    git init
    git branch -M main
    echo ✅ Git repository initialized
) else (
    echo ✅ Git repository already exists
)

echo.
echo STEP 2: CONFIGURE GIT USER
echo ==========================
echo.

REM Check if git user is configured
git config user.name >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Please enter your Git configuration:
    set /p git_name="Enter your name: "
    set /p git_email="Enter your email: "
    git config user.name "%git_name%"
    git config user.email "%git_email%"
    echo ✅ Git user configured
) else (
    echo ✅ Git user already configured
)

echo.
echo STEP 3: ADD REMOTE ORIGIN
echo ========================
echo.

REM Check if remote exists
git remote get-url origin >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Adding remote origin...
    git remote add origin https://github.com/sureshkumarpr/karate-api-automation.git
    echo ✅ Remote origin added
) else (
    echo ✅ Remote origin already exists
)

echo.
echo STEP 4: ADD ALL FILES TO STAGING
echo ================================
echo.

echo Adding all files to Git staging...
git add .

echo ✅ Files added to staging

echo.
echo STEP 5: CHECK WHAT WILL BE COMMITTED
echo ===================================
echo.

echo Files to be committed:
git status --porcelain

echo.
echo STEP 6: CREATE COMMIT
echo =====================
echo.

set commit_message="Complete Karate API Automation Setup - %date% %time%"
echo Committing with message: %commit_message%
git commit -m %commit_message%

if %ERRORLEVEL% EQU 0 (
    echo ✅ Files committed successfully
) else (
    echo ⚠️ No changes to commit or commit failed
)

echo.
echo STEP 7: PUSH TO MAIN BRANCH
echo ==========================
echo.

echo Pushing to main branch...
git push -u origin main

if %ERRORLEVEL% EQU 0 (
    echo ✅ Successfully pushed to main branch!
) else (
    echo ❌ Push failed. You may need to:
    echo    1. Check your GitHub credentials
    echo    2. Verify repository access
    echo    3. Try: git push -u origin main --force
)

echo.
echo ========================================
echo   COMMIT SUMMARY
echo ========================================
echo.

echo Repository: https://github.com/sureshkumarpr/karate-api-automation
echo Branch: main
echo Files committed: All Karate automation setup files
echo.

echo Files included in this commit:
echo - Report generation scripts
echo - Web server setup files
echo - Email configuration
echo - Installation guides
echo - Software download lists
echo - Windows setup scripts
echo - Java/Maven configuration guides
echo.

echo Next steps:
echo 1. Visit GitHub repository
echo 2. Enable GitHub Pages (if not done)
echo 3. Share URL with manager: https://sureshkumarpr.github.io/karate-api-automation/karate-summary.html
echo.

echo ========================================
echo   COMMIT COMPLETED!
echo ========================================
echo.

pause
