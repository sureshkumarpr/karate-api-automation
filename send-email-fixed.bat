@echo off
title Email Karate Report - Fixed Version
color 0E

echo ========================================
echo   Email Karate Report to Manager
echo ========================================
echo.

cd /d "C:\Users\Suresh Kumar PR\Documents\Divya_Project"

REM Check if report exists
if not exist "karate-summary.html" (
    echo Report file not found. Generating it first...
    call generate-report.bat
)

echo Email Configuration:
echo   Report URL: http://192.168.31.186:8080/karate-summary.html
echo.

powershell -ExecutionPolicy Bypass -File "email-report-fixed.ps1"

pause
