@echo off
title Quick Share - Karate Report
color 0A

echo ========================================
echo   Quick Share - Karate Report
echo ========================================
echo.
echo Your IP Address: 192.168.31.186
echo.
echo Starting web server...
echo.

cd /d "C:\Users\Suresh Kumar PR\Documents\Divya_Project"

REM Start PowerShell server directly
powershell -ExecutionPolicy Bypass -Command "
\$port = 8080;
\$ip = '192.168.31.186';
\$listener = New-Object System.Net.HttpListener;
\$listener.Prefixes.Add('http://+:' + \$port + '/');
try {
    \$listener.Start();
    Write-Host '✅ Server started successfully!' -ForegroundColor Green;
    Write-Host '';
    Write-Host '📱 URLs to share:' -ForegroundColor Cyan;
    Write-Host '   Local:   http://localhost:' + \$port + '/karate-summary.html' -ForegroundColor White;
    Write-Host '   Network: http://' + \$ip + ':' + \$port + '/karate-summary.html' -ForegroundColor Yellow;
    Write-Host '';
    Write-Host '🌐 Share this URL with your manager:' -ForegroundColor Green;
    Write-Host '   http://' + \$ip + ':' + \$port + '/karate-summary.html' -ForegroundColor Yellow;
    Write-Host '';
    Write-Host 'Press Ctrl+C to stop the server' -ForegroundColor Gray;
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
            
            if (Test-Path \$filePath -PathType Leaf) {
                \$content = [System.IO.File]::ReadAllBytes(\$filePath);
                \$response.ContentLength64 = \$content.Length;
                \$response.ContentType = 'text/html';
                \$response.Headers.Add('Access-Control-Allow-Origin', '*');
                \$response.OutputStream.Write(\$content, 0, \$content.Length);
                Write-Host '✓ Served: ' \$fileName -ForegroundColor Green;
            } else {
                \$response.StatusCode = 404;
                \$errorHtml = '<html><body><h1>404 - File Not Found</h1><p>File not found: ' + \$requestedPath + '</p><p><a href=\"/karate-summary.html\">Go to Report</a></p></body></html>';
                \$errorBytes = [System.Text.Encoding]::UTF8.GetBytes(\$errorHtml);
                \$response.ContentLength64 = \$errorBytes.Length;
                \$response.ContentType = 'text/html';
                \$response.OutputStream.Write(\$errorBytes, 0, \$errorBytes.Length);
                Write-Host '✗ 404: ' \$requestedPath -ForegroundColor Red;
            }
            
            \$response.Close();
        } catch {
            Write-Host 'Error: ' \$_ -ForegroundColor Red;
        }
    }
} catch {
    Write-Host '❌ Failed to start server: ' \$_ -ForegroundColor Red;
    Write-Host '';
    Write-Host 'Possible solutions:' -ForegroundColor Yellow;
    Write-Host '1. Port 8080 might be in use - close other applications' -ForegroundColor White;
    Write-Host '2. Run as Administrator' -ForegroundColor White;
    Write-Host '3. Check Windows Firewall settings' -ForegroundColor White;
    Write-Host '';
    pause;
}
"

echo.
echo Server stopped.
pause
