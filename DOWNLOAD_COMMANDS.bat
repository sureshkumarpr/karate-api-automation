@echo off
title Software Download Commands
color 0E

echo ========================================
echo   Software Download Commands
echo ========================================
echo.

echo These commands will download required software
echo with correct versions from official sources.
echo.

echo 1. GIT DOWNLOAD (Version 2.44.0)
echo    Size: 50MB | Time: 2 minutes
echo    Command: curl -L https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe -o git-installer.exe
echo.

echo 2. NODE.JS DOWNLOAD (Version 20.11.1 LTS)
echo    Size: 32MB | Time: 1 minute  
echo    Command: curl -L https://nodejs.org/dist/v20.11.1/node-v20.11.1-x64.msi -o nodejs-installer.msi
echo.

echo 3. CHROME DOWNLOAD (Latest Version)
echo    Size: 85MB | Time: 2 minutes
echo    Command: curl -L https://dl.google.com/chrome/chrome-for-enterprise/64/chrome-enterprise.msi -o chrome-installer.msi
echo.

echo 4. FIREFOX DOWNLOAD (Version 123.0)
echo    Size: 57MB | Time: 1 minute
echo    Command: curl -L https://download.mozilla.org/products/firefox-123.0.0-64bit/en-US/firefox-123.0.0.exe -o firefox-installer.exe
echo.

echo ========================================
echo   QUICK DOWNLOAD OPTIONS
echo ========================================
echo.

echo A. Download Git Only
echo B. Download Node.js Only  
echo C. Download Both Git + Node.js
echo D. Download All Software
echo E. Open Download Pages Manually
echo X. Exit
echo.

set /p choice="Select option (A/B/C/D/E/X): "

if /i "%choice%"=="A" (
    echo Downloading Git...
    curl -L https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe -o git-installer.exe
    echo Git downloaded successfully!
    echo Run: git-installer.exe
)

if /i "%choice%"=="B" (
    echo Downloading Node.js...
    curl -L https://nodejs.org/dist/v20.11.1/node-v20.11.1-x64.msi -o nodejs-installer.msi
    echo Node.js downloaded successfully!
    echo Run: nodejs-installer.msi
)

if /i "%choice%"=="C" (
    echo Downloading Git and Node.js...
    curl -L https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe -o git-installer.exe
    curl -L https://nodejs.org/dist/v20.11.1/node-v20.11.1-x64.msi -o nodejs-installer.msi
    echo Both downloaded successfully!
    echo Run: git-installer.exe then nodejs-installer.msi
)

if /i "%choice%"=="D" (
    echo Downloading all software...
    curl -L https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe -o git-installer.exe
    curl -L https://nodejs.org/dist/v20.11.1/node-v20.11.1-x64.msi -o nodejs-installer.msi
    curl -L https://dl.google.com/chrome/chrome-for-enterprise/64/chrome-enterprise.msi -o chrome-installer.msi
    curl -L https://download.mozilla.org/products/firefox-123.0.0-64bit/en-US/firefox-123.0.0.exe -o firefox-installer.exe
    echo All software downloaded!
)

if /i "%choice%"=="E" (
    echo Opening download pages...
    start https://git-scm.com/download/win
    start https://nodejs.org/en/download/
    start https://www.google.com/chrome/
    start https://www.mozilla.org/firefox/new/
)

if /i "%choice%"=="X" (
    echo Exiting...
    exit /b 0
)

echo.
echo Installation Instructions:
echo 1. Run git-installer.exe (if downloaded)
echo 2. Run nodejs-installer.msi (if downloaded)
echo 3. Restart computer after installation
echo.

pause
