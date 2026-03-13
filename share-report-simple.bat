@echo off
title Karate Report Web Server
color 0A

echo ========================================
echo   Karate Report Sharing Server
echo ========================================
echo.
echo This will start a web server to share your report
echo.
echo Your manager can access the report at:
echo   http://localhost:8080/karate-summary.html
echo.
echo For network access, use your IP address:
echo   http://[YOUR-IP]:8080/karate-summary.html
echo.
echo Press Ctrl+C to stop the server
echo.
pause

powershell -ExecutionPolicy Bypass -File "C:\Users\Suresh Kumar PR\Documents\Divya_Project\simple-web-server.ps1"
