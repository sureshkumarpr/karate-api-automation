# Generate Report and Start Web Server
Write-Host "Generating Karate Report and Starting Web Server..." -ForegroundColor Green

# Step 1: Generate the report
Write-Host "Step 1: Generating report..." -ForegroundColor Yellow
& "C:\Users\Suresh Kumar PR\Documents\Divya_Project\generate-report.ps1"

if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to generate report. Exiting." -ForegroundColor Red
    exit 1
}

# Step 2: Start web server
Write-Host "Step 2: Starting web server..." -ForegroundColor Yellow
& "C:\Users\Suresh Kumar PR\Documents\Divya_Project\start-web-server.ps1"
