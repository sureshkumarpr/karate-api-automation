@echo off
title Email Karate Report to Manager
color 0E

echo ========================================
echo   Email Karate Report to Manager
echo ========================================
echo.

echo This will send the test report URL to your manager.
echo.

cd /d "C:\Users\Suresh Kumar PR\Documents\Divya_Project"

REM Check if report exists
if not exist "karate-summary.html" (
    echo ❌ Report file not found. Generating it first...
    call generate-report.bat
)

echo 📧 Email Configuration:
echo   SMTP Server: smtp.gmail.com
echo   Port: 587
echo   Report URL: http://192.168.31.186:8080/karate-summary.html
echo.

echo 🌐 Starting email client...
powershell -ExecutionPolicy Bypass -File "C:\Users\Suresh Kumar PR\Documents\Divya_Project\email-report.ps1"

pause
