@echo off
title Karate Report Web Server
color 0A

echo ========================================
echo   Karate API Test Report Server
echo ========================================
echo.
echo This will:
echo 1. Generate the latest test report
echo 2. Start a web server to share it
echo 3. Provide URLs for your manager
echo.
echo Press Ctrl+C to stop the server at any time
echo.
pause

powershell -ExecutionPolicy Bypass -File "C:\Users\Suresh Kumar PR\Documents\Divya_Project\generate-and-serve.ps1"
