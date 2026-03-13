# Windows Installation Guide - Step by Step

## 🚀 For Manager's Windows Machine

### **Step 1: Check Current System**
```batch
# Open Command Prompt and check Windows version
winver
```
**Required**: Windows 10 or 11 (64-bit recommended)

---

## 📦 Software Installation Steps

### **Option A: View Reports Only (No Installation)**
**Step 1**: Open web browser (Chrome, Edge, Firefox)
**Step 2**: Go to: `https://sureshkumarpr.github.io/karate-api-automation/karate-summary.html`
**Step 3**: Bookmark the URL
**Total Time**: 2 minutes

---

### **Option B: Full Setup (For Development)**
**Install in this exact order:**

#### **Step 1: Install Git**
**Download**: https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe
**File Size**: 50.2 MB
**Installation**:
1. Double-click `Git-2.44.0-64-bit.exe`
2. Click "Next" → "Next" → "Next"
3. Select "Git from the command line and also from 3rd-party software"
4. Click "Next" → "Next" → "Install"
5. Click "Finish"
**Time**: 2-3 minutes

#### **Step 2: Install Node.js**
**Download**: https://nodejs.org/dist/v20.11.1/node-v20.11.1-x64.msi
**File Size**: 32.4 MB
**Installation**:
1. Double-click `node-v20.11.1-x64.msi`
2. Click "Next" → Accept license → "Next"
3. Use default settings → "Next"
4. Click "Install" → "Finish"
5. Restart computer
**Time**: 1-2 minutes

#### **Step 3: Verify Installation**
**Open Command Prompt and run**:
```batch
# Check Git
git --version
# Should show: git version 2.44.0.windows.1

# Check Node.js
node --version
# Should show: v20.11.1

# Check npm
npm --version
# Should show: 10.2.4
```

---

## 🎯 Complete Workflow for Manager

### **Scenario 1: Just View Reports**
1. **No installation needed**
2. **Open web browser**
3. **Go to**: `https://sureshkumarpr.github.io/karate-api-automation/karate-summary.html`
4. **Bookmark for future access**

### **Scenario 2: Run Project Locally**
1. **Install Git** (Step 1 above)
2. **Install Node.js** (Step 2 above)
3. **Restart computer**
4. **Clone repository**:
   ```batch
   git clone https://github.com/sureshkumarpr/karate-api-automation.git
   cd karate-api-automation
   ```
5. **Run local server**:
   ```batch
   npm install
   npm start
   # Or: node server.js
   ```
6. **Access at**: `http://localhost:8080/karate-summary.html`

---

## 🔧 Windows-Specific Commands

### **Check System Info**
```batch
# Windows version
systeminfo | findstr /B /C:"OS Name"

# 64-bit check
echo %PROCESSOR_ARCHITECTURE%

# Free space
dir C:\ | find "bytes free"
```

### **Environment Variables** (if needed)
```batch
# Add Node.js to PATH (usually automatic)
set PATH=%PATH%;C:\Program Files\nodejs\

# Add Git to PATH (usually automatic)
set PATH=%PATH%;C:\Program Files\Git\bin
```

---

## 📋 Installation Checklist

### **Before Installation**
- [ ] Windows 10/11 (64-bit)
- [ ] 4GB+ RAM available
- [ ] 2GB+ disk space free
- [ ] Administrator privileges
- [ ] Internet connection

### **Git Installation**
- [ ] Downloaded from official link
- [ ] Ran installer as Administrator
- [ ] Completed installation successfully
- [ ] Verified with `git --version`

### **Node.js Installation**
- [ ] Downloaded LTS version
- [ ] Ran installer as Administrator
- [ ] Completed installation successfully
- [ ] Verified with `node --version`
- [ ] Restarted computer

### **Final Verification**
- [ ] Both Git and Node.js working
- [ ] Can clone repository
- [ ] Can run local server
- [ ] Reports accessible via browser

---

## 🛠️ Troubleshooting Windows Issues

### **Git Issues**
**Problem**: 'git' not recognized
**Solution**: 
1. Restart Command Prompt
2. Check PATH: `echo %PATH%`
3. Add manually: `C:\Program Files\Git\cmd`

### **Node.js Issues**
**Problem**: 'node' not recognized
**Solution**:
1. Restart computer after installation
2. Check PATH: `echo %PATH%`
3. Add manually: `C:\Program Files\nodejs\`

### **Permission Issues**
**Problem**: Access denied during installation
**Solution**:
1. Right-click installer → "Run as Administrator"
2. Disable antivirus temporarily
3. Install in default location

---

## 📞 Quick Support Commands

### **After Installation**
```batch
# Clone project
git clone https://github.com/sureshkumarpr/karate-api-automation.git
cd karate-api-automation

# Install dependencies (if needed)
npm install

# Start server (if available)
npm start

# Or run report generator
generate-report.bat
```

---

## 🎯 Final Recommendation

**For your manager, I recommend:**

> **"Start with Option A - no installation needed. Just open your web browser and go to:
> 
> https://sureshkumarpr.github.io/karate-api-automation/karate-summary.html
> 
> This gives you instant access to all test reports from any device, anywhere in the world, with zero installation time."**

**If they want full development capabilities, then follow the Git + Node.js installation steps exactly as listed above.**

---

**Bottom Line: Windows installation is straightforward - just run the installers in order and restart!**
