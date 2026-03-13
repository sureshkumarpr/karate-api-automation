@echo off
title Karate Report Server - FINAL VERSION
color 0A

echo ========================================
echo   Karate Report Server - FINAL VERSION
echo ========================================
echo.
echo Your IP Address: 192.168.31.186
echo.
echo Starting server...
echo.

cd /d "C:\Users\Suresh Kumar PR\Documents\Divya_Project"

powershell -ExecutionPolicy Bypass -Command ^
"$port = 8080; ^
$ip = '192.168.31.186'; ^
$listener = New-Object System.Net.HttpListener; ^
$listener.Prefixes.Add('http://+:' + $port + '/'); ^
$listener.Start(); ^
Write-Host '✅ Server started!' -ForegroundColor Green; ^
Write-Host 'Local: http://localhost:' + $port + '/karate-summary.html' -ForegroundColor White; ^
Write-Host 'Network: http://' + $ip + ':' + $port + '/karate-summary.html' -ForegroundColor Yellow; ^
Write-Host 'Press Ctrl+C to stop' -ForegroundColor Gray; ^
while ($listener.IsListening) { ^
    $context = $listener.GetContext(); ^
    $request = $context.Request; ^
    $response = $context.Response; ^
    $requestedPath = $request.Url.LocalPath; ^
    if ($requestedPath -eq '/' -or $requestedPath -eq '') { ^
        $requestedPath = '/karate-summary.html'; ^
    } ^
    $fileName = $requestedPath.TrimStart('/'); ^
    $filePath = Join-Path 'C:\Users\Suresh Kumar PR\Documents\Divya_Project' $fileName; ^
    if (Test-Path $filePath -PathType Leaf) { ^
        $content = [System.IO.File]::ReadAllBytes($filePath); ^
        $response.ContentLength64 = $content.Length; ^
        $response.ContentType = 'text/html'; ^
        $response.OutputStream.Write($content, 0, $content.Length); ^
    } else { ^
        $response.StatusCode = 404; ^
    } ^
    $response.Close(); ^
}"

pause
