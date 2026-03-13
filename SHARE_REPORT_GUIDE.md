# Karate Report Sharing Guide

## Quick Start - Share Your Report in 3 Easy Steps

### Step 1: Generate Report (if not already done)
```batch
generate-report.bat
```

### Step 2: Start Web Server
```batch
start-server.bat
```

### Step 3: Share URLs with Your Manager

**Local Access (for testing):**
```
http://localhost:8080/karate-summary.html
```

**Network Access (for your manager):**
```
http://[YOUR-IP-ADDRESS]:8080/karate-summary.html
```

## How to Find Your IP Address

### Method 1: Using Command Prompt
```cmd
ipconfig
```
Look for "IPv4 Address" under your active network adapter.

### Method 2: Using PowerShell
```powershell
Get-NetIPAddress -AddressFamily IPv4 | Select-Object IPAddress, InterfaceAlias
```

### Method 3: Online
Visit: https://whatismyipaddress.com

## File Descriptions

| File | Purpose |
|------|---------|
| `generate-report.bat` | Generates the HTML report |
| `start-server.bat` | Starts web server to share report |
| `share-report.bat` | All-in-one solution |
| `karate-summary.html` | The actual report file |

## Security Notes

⚠️ **Important Security Information:**

1. **Local Network Only**: This server is designed for local network access
2. **Temporary Use**: Stop the server when done sharing
3. **Firewall**: May need to allow port 8080 through Windows Firewall
4. **No Authentication**: Anyone on your network can access the report

## Troubleshooting

### Port Already in Use
If port 8080 is busy, the script will show an error. You can:
- Close other applications using port 8080
- Modify the script to use a different port (e.g., 8081, 3000)

### Firewall Issues
If your manager cannot access the report:
1. Allow port 8080 through Windows Firewall
2. Check if your company network blocks incoming connections

### Report Not Found
If you see "File not found":
1. Run `generate-report.bat` first
2. Ensure `karate-summary.html` exists in the folder

## Advanced Options

### Custom Port
Edit `start-server.bat` and change `port = 8080` to your preferred port.

### Multiple Reports
The server can serve any file in the directory:
- `http://localhost:8080/karate-summary.html` - Main report
- `http://localhost:8080/karate-summary_1.html` - Template report

## One-Click Solution

For the easiest experience, simply run:
```batch
share-report.bat
```

This will:
1. ✅ Generate the latest report
2. ✅ Start the web server
3. ✅ Display the URLs to share
4. ✅ Keep running until you stop it

## Example URLs to Share

Replace `[YOUR-IP]` with your actual IP address:

```
http://192.168.1.100:8080/karate-summary.html
```

Or if your manager is on the same computer:
```
http://localhost:8080/karate-summary.html
```

## Stopping the Server

Press `Ctrl+C` in the server window to stop sharing.

---

**Note**: Your manager only needs a web browser to view the report - no special software required!
