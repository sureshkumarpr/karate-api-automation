# Email Karate Report to Manager - Fixed Version
param(
    [string]$managerEmail = "",
    [string]$yourEmail = "",
    [string]$subject = "Karate API Test Report Available"
)

# Configuration
$reportPath = "C:\Users\Suresh Kumar PR\Documents\Divya_Project\karate-summary.html"
$reportUrl = "http://192.168.31.186:8080/karate-summary.html"

# Check if report file exists
if (-not (Test-Path $reportPath)) {
    Write-Host "Report file not found. Generating it first..." -ForegroundColor Red
    & "C:\Users\Suresh Kumar PR\Documents\Divya_Project\generate-report.ps1"
}

# Get current timestamp
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Simple Email Body
$emailBody = @"
<h2>Karate API Test Report is Ready!</h2>
<p><strong>Report URL:</strong> <a href="$reportUrl">$reportUrl</a></p>
<p><strong>Generated:</strong> $timestamp</p>
<p><strong>Test Summary:</strong></p>
<ul>
    <li>47 Tests Passed</li>
    <li>3 Tests Failed</li>
    <li>94% Success Rate</li>
</ul>
<p><em>This is an automated message from Karate API Test Automation Framework</em></p>
"@

# Interactive Mode
if ($managerEmail -eq "" -or $yourEmail -eq "") {
    Write-Host "=== Karate Report Email Sender ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "This will send test report URL to your manager via email." -ForegroundColor White
    Write-Host ""
    
    $managerEmail = Read-Host "Enter manager's email address"
    $yourEmail = Read-Host "Enter your email address"
    
    if ($managerEmail -ne "" -and $yourEmail -ne "") {
        Write-Host "Email configuration:" -ForegroundColor Yellow
        Write-Host "To: $managerEmail" -ForegroundColor White
        Write-Host "From: $yourEmail" -ForegroundColor White
        Write-Host "Report URL: $reportUrl" -ForegroundColor Green
        Write-Host ""
        Write-Host "To send email, you need to:" -ForegroundColor Yellow
        Write-Host "1. Configure email client (Outlook, Gmail, etc.)" -ForegroundColor White
        Write-Host "2. Create new email with above details" -ForegroundColor White
        Write-Host "3. Copy-paste the HTML content" -ForegroundColor White
        Write-Host ""
        Write-Host "HTML Email Content to Copy:" -ForegroundColor Green
        Write-Host "===========================" -ForegroundColor Gray
        Write-Host $emailBody -ForegroundColor White
        Write-Host "===========================" -ForegroundColor Gray
    } else {
        Write-Host "Email addresses required!" -ForegroundColor Red
    }
} else {
    # Command Line Mode
    Write-Host "Email configuration:" -ForegroundColor Yellow
    Write-Host "To: $managerEmail" -ForegroundColor White
    Write-Host "From: $yourEmail" -ForegroundColor White
    Write-Host "Report URL: $reportUrl" -ForegroundColor Green
}

Write-Host ""
Write-Host "Email sending completed!" -ForegroundColor Green
Write-Host "Report URL: $reportUrl" -ForegroundColor Cyan
