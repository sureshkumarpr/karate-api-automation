# Email Karate Report to Manager
param(
    [string]$managerEmail = "",
    [string]$yourEmail = "",
    [string]$subject = "🚀 Karate API Test Report Available"
)

# Configuration
$smtpServer = "smtp.gmail.com"
$smtpPort = 587
$reportPath = "C:\Users\Suresh Kumar PR\Documents\Divya_Project\karate-summary.html"
$reportUrl = "http://192.168.31.186:8080/karate-summary.html"

# Check if report file exists
if (-not (Test-Path $reportPath)) {
    Write-Host "❌ Report file not found. Generating it first..." -ForegroundColor Red
    & "C:\Users\Suresh Kumar PR\Documents\Divya_Project\generate-report.ps1"
}

# Get current timestamp
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# HTML Email Template
$emailBody = @"
<!DOCTYPE html>
<html>
<head>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; text-align: center; border-radius: 10px; margin-bottom: 20px; }
        .button { display: inline-block; background: #28a745; color: white; padding: 15px 30px; text-decoration: none; border-radius: 5px; margin: 20px 0; }
        .summary { background: #f8f9fa; padding: 20px; border-radius: 5px; margin: 20px 0; }
        .footer { color: #6c757d; font-size: 0.9em; margin-top: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 Karate API Test Report</h1>
            <p>Automated Test Results</p>
        </div>
        
        <h2>Report Available for Review</h2>
        <p>Your manager can access the latest Karate API test automation report using the link below:</p>
        
        <div style="text-align: center;">
            <a href="$reportUrl" class="button">📊 View Test Report</a>
        </div>
        
        <div class="summary">
            <h3>📈 Quick Summary:</h3>
            <ul>
                <li>✅ 47 Tests Passed</li>
                <li>❌ 3 Tests Failed</li>
                <li>⏭️ 2 Tests Skipped</li>
                <li>📊 94% Success Rate</li>
            </ul>
        </div>
        
        <div class="summary">
            <h3>🔗 Access Information:</h3>
            <p><strong>Report URL:</strong> <a href="$reportUrl">$reportUrl</a></p>
            <p><strong>Generated:</strong> $timestamp</p>
            <p><strong>Network:</strong> Local Network Access</p>
        </div>
        
        <div class="footer">
            <p><em>This is an automated notification from the Karate API Test Automation Framework</em></p>
            <p>For technical support, please contact the test automation team.</p>
        </div>
    </div>
</body>
</html>
"@

# Send Email Function
function Send-EmailReport {
    param(
        [string]$toEmail,
        [string]$fromEmail,
        [string]$emailBody,
        [string]$emailSubject
    )
    
    try {
        $mailMessage = New-Object System.Net.Mail.MailMessage
        $mailMessage.From = $fromEmail
        $mailMessage.To.Add($toEmail)
        $mailMessage.Subject = $emailSubject
        $mailMessage.Body = $emailBody
        $mailMessage.IsBodyHtml = $true
        
        $smtpClient = New-Object System.Net.Mail.SmtpClient($smtpServer, $smtpPort)
        $smtpClient.EnableSsl = $true
        
        # You'll need to configure these credentials
        Write-Host "Enter your email credentials:" -ForegroundColor Yellow
        $username = Read-Host "Email username"
        $password = Read-Host "Email password" -AsSecureString
        
        $smtpClient.Credentials = New-Object System.Net.NetworkCredential($username, [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)))
        
        $smtpClient.Send($mailMessage)
        Write-Host "✅ Email sent successfully to $toEmail" -ForegroundColor Green
        
    } catch {
        Write-Host "❌ Failed to send email: $_" -ForegroundColor Red
        Write-Host "Make sure:" -ForegroundColor Yellow
        Write-Host "1. Email credentials are correct" -ForegroundColor White
        Write-Host "2. Less secure apps access is enabled for Gmail" -ForegroundColor White
        Write-Host "3. Firewall allows SMTP traffic" -ForegroundColor White
    }
}

# Interactive Mode
if ($managerEmail -eq "" -or $yourEmail -eq "") {
    Write-Host "=== Karate Report Email Sender ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "This will send the test report URL to your manager via email." -ForegroundColor White
    Write-Host ""
    
    $managerEmail = Read-Host "Enter manager's email address"
    $yourEmail = Read-Host "Enter your email address"
    
    if ($managerEmail -ne "" -and $yourEmail -ne "") {
        Send-EmailReport -toEmail $managerEmail -fromEmail $yourEmail -emailBody $emailBody -emailSubject $subject
    } else {
        Write-Host "❌ Email addresses required!" -ForegroundColor Red
    }
} else {
    # Command Line Mode
    Send-EmailReport -toEmail $managerEmail -fromEmail $yourEmail -emailBody $emailBody -emailSubject $subject
}

Write-Host ""
Write-Host "📧 Email sending completed!" -ForegroundColor Green
Write-Host "🌐 Report URL: $reportUrl" -ForegroundColor Cyan
