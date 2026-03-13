# Troubleshooting Guide - "Site Can't Be Reached"

## 🚨 Quick Fix Steps

### 1. Run the FINAL-SERVER.bat
```batch
FINAL-SERVER.bat
```

### 2. Check These URLs
- **Local Test**: `http://localhost:8080/karate-summary.html`
- **Network Share**: `http://192.168.31.186:8080/karate-summary.html`

### 3. If Still Not Working, Try These Solutions:

---

## 🔧 Common Issues & Solutions

### Issue 1: Port 8080 Already in Use
**Symptoms**: Server fails to start, "address already in use" error

**Solutions**:
1. Close other applications using port 8080
2. Run Task Manager and close Java/Node.js processes
3. Use different port (change 8080 to 8081 in the batch file)

### Issue 2: Windows Firewall Blocking
**Symptoms**: Local works, but network access fails

**Solutions**:
1. **Allow through Windows Firewall**:
   - Go to Windows Security → Firewall & network protection
   - Click "Allow an app through firewall"
   - Add "Windows PowerShell" and allow port 8080

2. **Temporarily disable firewall** (for testing only):
   ```cmd
   netsh advfirewall set allprofiles state off
   ```

### Issue 3: Network Configuration
**Symptoms**: Cannot access from other devices

**Solutions**:
1. **Check if devices are on same network**:
   - Your computer: 192.168.31.186
   - Manager's device should be: 192.168.31.xxx

2. **Use correct IP address**:
   ```cmd
   ipconfig
   ```
   Look for "IPv4 Address" under your active adapter

### Issue 4: Permissions
**Symptoms**: "Access denied" errors

**Solutions**:
1. **Run as Administrator**:
   - Right-click the batch file
   - Select "Run as administrator"

2. **Check file permissions**:
   - Right-click `karate-summary.html`
   - Properties → Security → Ensure "Everyone" has read access

---

## 🌐 Alternative Solutions

### Option 1: Use Different Port
Edit `FINAL-SERVER.bat` and change `8080` to `8081`:
```
http://192.168.31.186:8081/karate-summary.html
```

### Option 2: Use Python (if available)
```cmd
python -m http.server 8080
```
Then access: `http://192.168.31.186:8080/karate-summary.html`

### Option 3: Use Node.js (if available)
```cmd
npx http-server -p 8080
```

---

## 📱 Testing Steps

### Step 1: Test Local Access
1. Run `FINAL-SERVER.bat`
2. Open browser on YOUR computer
3. Go to: `http://localhost:8080/karate-summary.html`
4. **If this works**, server is running correctly

### Step 2: Test Network Access
1. On YOUR computer, go to: `http://192.168.31.186:8080/karate-summary.html`
2. **If this works**, network sharing is working
3. Share this URL with your manager

### Step 3: Test from Another Device
1. Use phone/tablet on same WiFi
2. Go to: `http://192.168.31.186:8080/karate-summary.html`
3. **If this works**, your manager can access it

---

## 🆘 Emergency Solutions

### Solution A: Copy File Directly
If server doesn't work:
1. Copy `karate-summary.html` to USB drive
2. Share file directly with manager
3. Manager can open file in any browser

### Solution B: Email Attachment
1. Attach `karate-summary.html` to email
2. Send to manager
3. Manager can save and open in browser

### Solution C: Cloud Storage
1. Upload `karate-summary.html` to Google Drive/Dropbox
2. Share link with manager
3. Manager can view online

---

## 📞 Support Information

### Your Network Details:
- **IP Address**: 192.168.31.186
- **Port**: 8080
- **Report File**: karate-summary.html
- **File Location**: C:\Users\Suresh Kumar PR\Documents\Divya_Project\

### Success Indicators:
✅ Server starts without errors  
✅ "Server started successfully!" message appears  
✅ Local URL works in your browser  
✅ Network URL works on your computer  
✅ Manager can access from their device  

---

**Remember**: The server only runs while the command window is open. Don't close it until your manager has viewed the report!
