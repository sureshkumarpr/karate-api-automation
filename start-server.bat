@echo off
title Karate Report Server
color 0A

echo ========================================
echo   Karate API Test Report Server
echo ========================================
echo.
echo Starting web server...
echo.

cd /d "C:\Users\Suresh Kumar PR\Documents\Divya_Project"

REM Try to start with Node.js if available
where node >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo Using Node.js server...
    node -e "
const http = require('http');
const fs = require('fs');
const path = require('path');
const port = 8080;

const server = http.createServer((req, res) => {
    let filePath = '.' + req.url;
    if (filePath === './') filePath = './karate-summary.html';
    
    const extname = String(path.extname(filePath)).toLowerCase();
    const mimeTypes = {
        '.html': 'text/html',
        '.css': 'text/css',
        '.js': 'application/javascript'
    };
    
    const contentType = mimeTypes[extname] || 'application/octet-stream';
    
    fs.readFile(filePath, (error, content) => {
        if (error) {
            res.writeHead(404);
            res.end('File not found');
        } else {
            res.writeHead(200, { 'Content-Type': contentType });
            res.end(content, 'utf-8');
        }
    });
});

server.listen(port, () => {
    console.log('Server running at http://localhost:' + port);
    console.log('Report available at: http://localhost:' + port + '/karate-summary.html');
    console.log('Press Ctrl+C to stop');
});
"
) else (
    echo Node.js not found. Using PowerShell method...
    powershell -ExecutionPolicy Bypass -Command "
    \$port = 8080;
    \$listener = New-Object System.Net.HttpListener;
    \$listener.Prefixes.Add('http://localhost:' + \$port + '/');
    \$listener.Start();
    Write-Host 'Server running at http://localhost:' + \$port;
    Write-Host 'Report available at: http://localhost:' + \$port + '/karate-summary.html';
    Write-Host 'Press Ctrl+C to stop';
    
    while (\$listener.IsListening) {
        \$context = \$listener.GetContext();
        \$request = \$context.Request;
        \$response = \$context.Response;
        
        \$requestedPath = \$request.Url.LocalPath;
        if (\$requestedPath -eq '/' -or \$requestedPath -eq '') {
            \$requestedPath = '/karate-summary.html';
        }
        
        \$fileName = \$requestedPath.TrimStart('/');
        \$filePath = Join-Path 'C:\Users\Suresh Kumar PR\Documents\Divya_Project' \$fileName;
        
        if (Test-Path \$filePath -PathType Leaf) {
            \$content = [System.IO.File]::ReadAllBytes(\$filePath);
            \$response.ContentLength64 = \$content.Length;
            \$response.ContentType = 'text/html';
            \$response.OutputStream.Write(\$content, 0, \$content.Length);
        } else {
            \$response.StatusCode = 404;
        }
        
        \$response.Close();
    }
    "
)

echo.
echo Server stopped.
pause
