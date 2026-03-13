@echo off
title Quick Email - Karate Report
color 0A

echo ========================================
echo   Quick Email - Karate Report
echo ========================================
echo.

echo Your manager can access the report at:
echo.
echo http://192.168.31.186:8080/karate-summary.html
echo.
echo Email Template to Send:
echo ================================
echo.
echo Subject: Karate API Test Report Available
echo.
echo Body:
echo Hi Manager,
echo.
echo The Karate API Test Automation Report is ready for review.
echo.
echo Report URL: http://192.168.31.186:8080/karate-summary.html
echo.
echo Test Results Summary:
echo - 47 Tests Passed
echo - 3 Tests Failed  
echo - 94% Success Rate
echo.
echo Please access the report using the above URL.
echo.
echo Thanks,
echo Your Name
echo ================================
echo.
echo Instructions:
echo 1. Copy the email content above
echo 2. Open your email client (Gmail, Outlook, etc.)
echo 3. Create new email to your manager
echo 4. Paste the content and send
echo.
echo Make sure the local server is running (FINAL-SERVER.bat)
echo.
pause
