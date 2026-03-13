# Start Web Server to Host Karate Report
Write-Host "Starting Web Server for Karate Report..." -ForegroundColor Green

$port = 8080
$reportPath = "C:\Users\Suresh Kumar PR\Documents\Divya_Project"
$reportFile = "karate-summary.html"

try {
    # Check if report file exists
    $fullReportPath = Join-Path $reportPath $reportFile
    if (-not (Test-Path $fullReportPath)) {
        Write-Host "Error: Report file not found at $fullReportPath" -ForegroundColor Red
        Write-Host "Please run generate-report.ps1 first to create the report." -ForegroundColor Yellow
        exit 1
    }

    # Create a simple HTTP listener
    $listener = New-Object System.Net.HttpListener
    $listener.Prefixes.Add("http://localhost:$port/")
    $listener.Start()

    Write-Host "Web server started successfully!" -ForegroundColor Green
    Write-Host "Report URL: http://localhost:$port/$reportFile" -ForegroundColor Cyan
    Write-Host "Local Network URL: http://$((Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias 'Ethernet*').IPAddress[0]):$port/$reportFile" -ForegroundColor Yellow
    Write-Host "Press Ctrl+C to stop the server" -ForegroundColor White
    Write-Host "" -ForegroundColor White

    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        # Get the requested URL
        $requestedPath = $request.Url.LocalPath
        
        # Default to karate-summary.html if root is requested
        if ($requestedPath -eq "/" -or $requestedPath -eq "") {
            $requestedPath = "/$reportFile"
        }

        # Remove leading slash and construct full file path
        $fileName = $requestedPath.TrimStart('/')
        $filePath = Join-Path $reportPath $fileName

        if (Test-Path $filePath -PathType Leaf) {
            # Serve the file
            $content = [System.IO.File]::ReadAllBytes($filePath)
            $response.ContentLength64 = $content.Length
            
            # Set content type based on file extension
            $extension = [System.IO.Path]::GetExtension($fileName).ToLower()
            switch ($extension) {
                ".html" { $response.ContentType = "text/html" }
                ".css" { $response.ContentType = "text/css" }
                ".js" { $response.ContentType = "application/javascript" }
                ".png" { $response.ContentType = "image/png" }
                ".jpg" { $response.ContentType = "image/jpeg" }
                ".gif" { $response.ContentType = "image/gif" }
                default { $response.ContentType = "application/octet-stream" }
            }
            
            $response.OutputStream.Write($content, 0, $content.Length)
        } else {
            # File not found
            $response.StatusCode = 404
            $response.ContentType = "text/html"
            $errorHtml = @"
            <html>
            <body>
                <h1>404 - File Not Found</h1>
                <p>The requested file '$requestedPath' was not found.</p>
                <p><a href="/$reportFile">View Karate Report</a></p>
            </body>
            </html>
            "@
            $errorBytes = [System.Text.Encoding]::UTF8.GetBytes($errorHtml)
            $response.ContentLength64 = $errorBytes.Length
            $response.OutputStream.Write($errorBytes, 0, $errorBytes.Length)
        }

        $response.Close()
    }
} catch {
    Write-Host "Error starting web server: $_" -ForegroundColor Red
} finally {
    if ($listener -and $listener.IsListening) {
        $listener.Stop()
        Write-Host "Web server stopped." -ForegroundColor Yellow
    }
}
