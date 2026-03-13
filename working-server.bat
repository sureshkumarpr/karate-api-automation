@echo off
title Karate Report Server - Working Version
color 0A

echo ========================================
echo   Karate Report Server - Working Version
echo ========================================
echo.
echo Your IP Address: 192.168.31.186
echo.
echo Starting server...
echo.

cd /d "C:\Users\Suresh Kumar PR\Documents\Divya_Project"

REM Check if Python is available
python --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Starting Python server...
    python test-server.py
) else (
    echo Python not found. Trying PowerShell method...
    powershell -ExecutionPolicy Bypass -Command "
    \$port = 8080;
    \$ip = '192.168.31.186';
    \$listener = New-Object System.Net.HttpListener;
    \$listener.Prefixes.Add('http://+:' + \$port + '/');
    \$listener.Start();
    Write-Host 'Server started successfully!' -ForegroundColor Green;
    Write-Host 'Local URL: http://localhost:' + \$port + '/karate-summary.html' -ForegroundColor Cyan;
    Write-Host 'Network URL: http://' + \$ip + ':' + \$port + '/karate-summary.html' -ForegroundColor Yellow;
    Write-Host 'Press Ctrl+C to stop the server' -ForegroundColor White;
    Write-Host '';
    
    while (\$listener.IsListening) {
        try {
            \$context = \$listener.GetContext();
            \$request = \$context.Request;
            \$response = \$context.Response;
            
            \$requestedPath = \$request.Url.LocalPath;
            if (\$requestedPath -eq '/' -or \$requestedPath -eq '') {
                \$requestedPath = '/karate-summary.html';
            }
            
            \$fileName = \$requestedPath.TrimStart('/');
            \$filePath = Join-Path 'C:\Users\Suresh Kumar PR\Documents\Divya_Project' \$fileName;
            
            Write-Host 'Request: ' \$requestedPath -ForegroundColor Gray;
            
            if (Test-Path \$filePath -PathType Leaf) {
                \$content = [System.IO.File]::ReadAllBytes(\$filePath);
                \$response.ContentLength64 = \$content.Length;
                \$response.ContentType = 'text/html';
                \$response.Headers.Add('Access-Control-Allow-Origin', '*');
                \$response.OutputStream.Write(\$content, 0, \$content.Length);
                Write-Host 'Served: ' \$fileName -ForegroundColor Green;
            } else {
                \$response.StatusCode = 404;
                \$errorHtml = '<html><body><h1>404 - File Not Found</h1><p>File not found: ' + \$requestedPath + '</p><p><a href=\"/karate-summary.html\">Go to Report</a></p></body></html>';
                \$errorBytes = [System.Text.Encoding]::UTF8.GetBytes(\$errorHtml);
                \$response.ContentLength64 = \$errorBytes.Length;
                \$response.ContentType = 'text/html';
                \$response.OutputStream.Write(\$errorBytes, 0, \$errorBytes.Length);
                Write-Host '404: ' \$requestedPath -ForegroundColor Red;
            }
            
            \$response.Close();
        } catch {
            Write-Host 'Error processing request: ' \$_ -ForegroundColor Red;
        }
    }
    "
)

echo.
echo Server stopped.
pause
