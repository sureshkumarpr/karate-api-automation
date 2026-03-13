@echo off
echo Generating Karate API Test Report...
node generate-report.js
echo Report generated successfully!
echo Opening report...
start "" "C:\Users\Suresh Kumar PR\Documents\Divya_Project\karate-summary.html"
pause
