@echo off
title Check Windows Bit Version
color 0B

echo ========================================
echo   Check Windows Bit Version
echo ========================================
echo.

echo METHOD 1: Using System Information
echo ================================
echo.
systeminfo | findstr /B /C:"System Type"
echo.

echo METHOD 2: Using Environment Variables
echo ===================================
echo.
echo Processor Architecture:
echo PROCESSOR_ARCHITECTURE = %PROCESSOR_ARCHITECTURE%
echo.
if defined PROCESSOR_ARCHITECTURE_W6432 (
    echo PROCESSOR_ARCHITECTURE_W6432 = %PROCESSOR_ARCHITECTURE_W6432%
    echo This indicates 64-bit Windows with 32-bit compatibility
) else (
    echo PROCESSOR_ARCHITECTURE_W6432 = Not defined (32-bit Windows)
)
echo.

echo METHOD 3: Using WMIC
echo ==================
echo.
wmic os get OSArchitecture
echo.

echo METHOD 4: Using PowerShell
echo =========================
echo.
powershell -Command "Get-WmiObject -Class Win32_OperatingSystem | Select-Object OSArchitecture"
echo.

echo ========================================
echo   INTERPRETATION GUIDE
echo ========================================
echo.
echo Results Guide:
echo --------------
echo "x64-based PC" or "64-bit" = 64-bit Windows
echo "x86-based PC" or "32-bit" = 32-bit Windows
echo.
echo Environment Variables:
echo ----------------------
echo PROCESSOR_ARCHITECTURE = AMD64 or x86_64 = 64-bit Windows
echo PROCESSOR_ARCHITECTURE = x86 = 32-bit Windows
echo.
echo If PROCESSOR_ARCHITECTURE_W6432 is defined = 64-bit Windows
echo If PROCESSOR_ARCHITECTURE_W6432 is NOT defined = 32-bit Windows
echo.

echo ========================================
echo   QUICK RESULT
echo ========================================
echo.

REM Quick check
if defined PROCESSOR_ARCHITECTURE_W6432 (
    echo ✅ Your Windows is: 64-bit
    echo    You can install 64-bit software
    echo    Recommended: Download x64 versions
) else if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo ✅ Your Windows is: 64-bit
    echo    You can install 64-bit software
    echo    Recommended: Download x64 versions
) else if "%PROCESSOR_ARCHITECTURE%"=="x86_64" (
    echo ✅ Your Windows is: 64-bit
    echo    You can install 64-bit software
    echo    Recommended: Download x64 versions
) else (
    echo ✅ Your Windows is: 32-bit
    echo    You can only install 32-bit software
    echo    Recommended: Download x86 versions
)

echo.
echo ========================================
echo   SOFTWARE DOWNLOAD RECOMMENDATIONS
echo ========================================
echo.

if defined PROCESSOR_ARCHITECTURE_W6432 (
    echo For your 64-bit Windows, download:
    echo - Java: OpenJDK17U-jdk_x64_windows_hotspot_17.0.10_7.msi
    echo - Maven: apache-maven-3.9.6-bin.zip (works for both)
    echo - Git: Git-2.44.0-64-bit.exe
    echo - Node.js: node-v20.11.1-x64.msi
) else if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo For your 64-bit Windows, download:
    echo - Java: OpenJDK17U-jdk_x64_windows_hotspot_17.0.10_7.msi
    echo - Maven: apache-maven-3.9.6-bin.zip (works for both)
    echo - Git: Git-2.44.0-64-bit.exe
    echo - Node.js: node-v20.11.1-x64.msi
) else if "%PROCESSOR_ARCHITECTURE%"=="x86_64" (
    echo For your 64-bit Windows, download:
    echo - Java: OpenJDK17U-jdk_x64_windows_hotspot_17.0.10_7.msi
    echo - Maven: apache-maven-3.9.6-bin.zip (works for both)
    echo - Git: Git-2.44.0-64-bit.exe
    echo - Node.js: node-v20.11.1-x64.msi
) else (
    echo For your 32-bit Windows, download:
    echo - Java: OpenJDK17U-jdk_x86_windows_hotspot_17.0.10_7.msi
    echo - Maven: apache-maven-3.9.6-bin.zip (works for both)
    echo - Git: Git-2.44.0-32-bit.exe
    echo - Node.js: node-v20.11.1-x86.msi
)

echo.
echo ========================================
echo   VISUAL METHOD
echo ========================================
echo.
echo You can also check visually:
echo 1. Right-click "This PC" → "Properties"
echo 2. Look for "System type" (e.g., "64-bit operating system")
echo 3. Or: Settings → System → About → Device specifications
echo.

pause
