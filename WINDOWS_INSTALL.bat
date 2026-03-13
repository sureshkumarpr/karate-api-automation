@echo off
title Windows Installation - Step by Step
color 0B

echo ========================================
echo   Windows Installation - Step by Step
echo ========================================
echo.

echo This guide will install the right software
echo for your manager's Windows machine.
echo.

echo STEP 1: CHECKING SYSTEM
echo ==========================
echo.

REM Check Windows version
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
echo Windows Version: %VERSION%

REM Check 64-bit
if defined PROCESSOR_ARCHITECTURE_W6432 (
    echo Architecture: 64-bit
) else (
    echo Architecture: %PROCESSOR_ARCHITECTURE%
)

echo.
echo STEP 2: INSTALLATION OPTIONS
echo ==========================
echo.
echo A. VIEW REPORTS ONLY (Recommended)
echo    Software: Web browser only
echo    Installation: None needed
echo    Time: 2 minutes
echo.
echo B. FULL DEVELOPMENT SETUP
echo    Software: Git + Node.js + Browser
echo    Installation: 5 minutes
echo    Purpose: Clone and run locally
echo.
echo C. DOWNLOAD SOFTWARE ONLY
echo    Downloads installers to desktop
echo    Manual installation required
echo.
echo X. EXIT
echo.

set /p choice="Select option (A/B/C/X): "

if /i "%choice%"=="A" goto VIEW_ONLY
if /i "%choice%"=="B" goto FULL_SETUP
if /i "%choice%"=="C" goto DOWNLOAD_ONLY
if /i "%choice%"=="X" goto END

:VIEW_ONLY
echo.
echo ========================================
echo   VIEW REPORTS ONLY
echo ========================================
echo.
echo No installation required!
echo.
echo Your manager can access reports at:
echo https://sureshkumarpr.github.io/karate-api-automation/karate-summary.html
echo.
echo Instructions:
echo 1. Open web browser
echo 2. Go to URL above
echo 3. Bookmark for future access
echo.
goto END

:FULL_SETUP
echo.
echo ========================================
echo   FULL DEVELOPMENT SETUP
echo ========================================
echo.
echo Installing Git and Node.js for Windows...
echo.

REM Download Git
echo Downloading Git (50MB)...
curl -L "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe" -o "%USERPROFILE%\Desktop\Git-2.44.0-64-bit.exe"

REM Download Node.js
echo Downloading Node.js (32MB)...
curl -L "https://nodejs.org/dist/v20.11.1/node-v20.11.1-x64.msi" -o "%USERPROFILE%\Desktop\node-v20.11.1-x64.msi"

echo.
echo Downloads completed!
echo Files saved to Desktop:
echo - Git-2.44.0-64-bit.exe
echo - node-v20.11.1-x64.msi
echo.
echo Installation Instructions:
echo 1. Run Git-2.44.0-64-bit.exe first
echo 2. Run node-v20.11.1-x64.msi second
echo 3. Restart computer after both installations
echo 4. Open Command Prompt and verify with:
echo    git --version
echo    node --version
echo.
goto END

:DOWNLOAD_ONLY
echo.
echo ========================================
echo   DOWNLOAD SOFTWARE ONLY
echo ========================================
echo.

REM Create downloads directory
if not exist "%USERPROFILE%\Downloads\KarateSetup" mkdir "%USERPROFILE%\Downloads\KarateSetup"

REM Download Git
echo Downloading Git installer...
curl -L "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe" -o "%USERPROFILE%\Downloads\KarateSetup\Git-2.44.0-64-bit.exe"

REM Download Node.js
echo Downloading Node.js installer...
curl -L "https://nodejs.org/dist/v20.11.1/node-v20.11.1-x64.msi" -o "%USERPROFILE%\Downloads\KarateSetup\node-v20.11.1-x64.msi"

REM Download Chrome (optional)
echo Downloading Chrome installer...
curl -L "https://dl.google.com/chrome/chrome-for-enterprise/64/chrome-enterprise.msi" -o "%USERPROFILE%\Downloads\KarateSetup\chrome-enterprise.msi"

echo.
echo Downloads completed!
echo Files saved to: %USERPROFILE%\Downloads\KarateSetup\
echo.
echo Contents:
dir "%USERPROFILE%\Downloads\KarateSetup"
echo.
echo Installation order:
echo 1. Git-2.44.0-64-bit.exe
echo 2. node-v20.11.1-x64.msi
echo 3. chrome-enterprise.msi (optional)
echo.
echo Run each installer and restart when finished.
echo.

:END
echo.
echo Installation guide completed!
echo.
echo For detailed instructions, see: WINDOWS_INSTALLATION_GUIDE.md
echo.
pause
