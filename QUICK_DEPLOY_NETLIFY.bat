@echo off
title Quick Deploy - Netlify (Faster than GitHub)
color 0D

echo ========================================
echo   Quick Deploy - Netlify Alternative
echo ========================================
echo.

echo This will deploy your report to Netlify
echo and give you an instant working URL.
echo.

cd /d "C:\Users\Suresh Kumar PR\Documents\Divya_Project"

REM Check if report exists
if not exist "karate-summary.html" (
    echo ❌ Report file not found. Generating it first...
    call generate-report.bat
)

echo 🌐 Opening Netlify Drop Deployment...
echo.
echo Instructions:
echo 1. Browser will open to Netlify
echo 2. Drag karate-summary.html into the drop zone
echo 3. Wait for deployment (30 seconds)
echo 4. Copy the URL provided
echo 5. Share URL with your manager
echo.
echo Opening Netlify now...
start https://app.netlify.com/drop

echo.
echo ⏳ Waiting for you to complete deployment...
echo.
echo After deployment, you'll get a URL like:
echo https://random-name-123456.netlify.app
echo.
echo Share this URL with your manager - it works instantly!
echo.
pause
