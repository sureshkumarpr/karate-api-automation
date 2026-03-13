# Git Installation Guide for Windows

**Author**: Divya.V, II MSc Computer Science, Gobi Arts and Science College (Autonomous), Gobichettipalayam, Erode District, Pin 638458

---

## 🚀 **Option 1: Git for Windows (Recommended)**

### **Step-by-Step Installation**

#### **Step 1: Download Git**
```
1. Go to: https://git-scm.com/download/win
2. Click the download link for Windows
3. Save the installer (e.g., Git-2.43.0-64-bit.exe)
```

#### **Step 2: Run Installer**
```
1. Double-click the downloaded installer
2. Click "Next" on welcome screen
3. Choose installation location (default is fine)
4. Select components:
   ✅ Git GUI Here
   ✅ Git Bash Here
   ✅ Git LFS (Large File Support)
   ✅ Associate .git files
5. Click "Next"
```

#### **Step 3: Choose Default Editor**
```
Select: "Use Vim (the ubiquitous text editor)"
OR
Select: "Use Notepad++" (if installed)
Click "Next"
```

#### **Step 4: Configure PATH Environment**
```
Select: "Use Git from the Windows Command Prompt"
This allows you to use git in PowerShell/CMD
Click "Next"
```

#### **Step 5: Choose HTTPS Transport**
```
Select: "Use the OpenSSL library"
This is the standard option
Click "Next"
```

#### **Step 6: Configure Line Endings**
```
Select: "Checkout Windows-style, commit Unix-style line endings"
Recommended for Windows users
Click "Next"
```

#### **Step 7: Choose Terminal**
```
Select: "Use Windows' default console window"
Click "Next"
```

#### **Step 8: Configure Extra Options**
```
Keep default settings:
✅ Enable file system caching
✅ Enable Git Credential Manager
Click "Install"
```

#### **Step 9: Complete Installation**
```
Wait for installation to complete
Click "Finish"
```

#### **Step 10: Verify Installation**
```
Open Command Prompt or PowerShell and type:
git --version

Expected output:
git version 2.43.0.windows.1
```

---

## 🌐 **Option 2: GitHub Desktop (GUI Method)**

### **Installation Steps**

#### **Step 1: Download GitHub Desktop**
```
1. Go to: https://desktop.github.com/
2. Click "Download for Windows"
3. Save the installer
```

#### **Step 2: Install GitHub Desktop**
```
1. Double-click the installer
2. Follow installation wizard
3. Launch GitHub Desktop
```

#### **Step 3: Configure GitHub Desktop**
```
1. Sign in with GitHub account
2. Configure your name and email
3. Git will be installed automatically
```

#### **Step 4: Use Git Command Line**
```
After GitHub Desktop installation:
1. Open Command Prompt
2. Type: git --version
3. Git should be available system-wide
```

---

## 📦 **Option 3: Windows Package Manager (winget)**

### **For Windows 10/11**

#### **Step 1: Open PowerShell as Administrator**
```
1. Right-click Start button
2. Select "Windows PowerShell (Admin)"
3. Click "Yes" on UAC prompt
```

#### **Step 2: Install Git with winget**
```
Type the following command:
winget install --id Git.Git -e --source winget

Wait for installation to complete
```

#### **Step 3: Verify Installation**
```
Close and reopen PowerShell
Type: git --version
```

---

## 🍫 **Option 4: Chocolatey Package Manager**

### **Installation Steps**

#### **Step 1: Install Chocolatey**
```
1. Open PowerShell as Administrator
2. Run this command:
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

#### **Step 2: Install Git with Chocolatey**
```
Type: choco install git
Press 'Y' when prompted
```

#### **Step 3: Verify Installation**
```
Close and reopen PowerShell
Type: git --version
```

---

## 🏪 **Option 5: Microsoft Store**

### **Easy Installation**

#### **Step 1: Open Microsoft Store**
```
1. Click Start button
2. Type "Microsoft Store"
3. Open Microsoft Store
```

#### **Step 2: Search and Install Git**
```
1. Search for "Git"
2. Click "Git" by GitHub Inc.
3. Click "Get" or "Install"
```

#### **Step 3: Verify Installation**
```
Open Command Prompt and type:
git --version
```

---

## 🎯 **Option 6: Visual Studio Installer**

### **If You Have Visual Studio**

#### **Step 1: Run Visual Studio Installer**
```
1. Open Visual Studio Installer
2. Click "Modify" on your VS installation
```

#### **Step 2: Add Git Component**
```
1. Go to "Individual components" tab
2. Search for "Git"
3. Check "Git for Windows"
4. Click "Modify"
```

#### **Step 3: Verify Installation**
```
Open Developer Command Prompt and type:
git --version
```

---

## 🔍 **Verification Steps**

### **After Installation**

#### **Step 1: Check Git Version**
```bash
git --version
# Expected: git version 2.x.x
```

#### **Step 2: Configure Git**
```bash
git config --global user.name "Divya.V"
git config --global user.email "divya.v@example.com"
```

#### **Step 3: Test Git**
```bash
git --help
# Should show Git help information
```

---

## 🚨 **Troubleshooting**

### **Common Issues**

#### **Issue 1: 'git' is not recognized**
```
Solution: Restart Command Prompt/PowerShell
If still not working, add Git to PATH:
1. Find Git installation (usually C:\Program Files\Git\bin)
2. Add to System Environment Variables PATH
3. Restart Command Prompt
```

#### **Issue 2: Installation fails**
```
Solution: Run installer as Administrator
1. Right-click installer
2. Select "Run as administrator"
```

#### **Issue 3: Network issues**
```
Solution: Download offline installer
1. Use different network
2. Download from different browser
3. Try again later
```

---

## 🎯 **Recommended Method**

### **For Your Project**

#### **Best Choice: Git for Windows**
```
✅ Most reliable
✅ Full command-line support
✅ Integrates with Windows
✅ Industry standard
✅ Regular updates
```

#### **Alternative: GitHub Desktop**
```
✅ GUI interface
✅ Easy for beginners
✅ Includes Git command line
✅ Good for learning
```

---

## 📋 **Post-Installation Setup**

### **Configure Git for Your Project**
```bash
# Set your name
git config --global user.name "Divya.V"

# Set your email
git config --global user.email "divya.v@example.com"

# Set default branch name
git config --global init.defaultBranch main

# Verify configuration
git config --list
```

### **Test Git with Your Project**
```bash
# Navigate to your project
cd "c:/Users/Suresh Kumar PR/Documents/Divya_Project"

# Now you can run the upload script
upload-to-github.bat
```

---

## 📊 **Installation Comparison**

| Method | Ease of Use | Features | Size | Best For |
|--------|-------------|----------|------|----------|
| **Git for Windows** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | 50MB | Most users |
| **GitHub Desktop** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | 200MB | Beginners |
| **winget** | ⭐⭐⭐ | ⭐⭐⭐⭐ | 50MB | Windows 10/11 |
| **Chocolatey** | ⭐⭐⭐ | ⭐⭐⭐⭐ | 50MB | DevOps users |
| **Microsoft Store** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | 100MB | Casual users |
| **VS Installer** | ⭐⭐ | ⭐⭐⭐ | 50MB | VS users |

---

## 🎓 **Academic Context**

### **Why Git Installation is Important**
- ✅ **Version Control**: Essential for software development
- ✅ **Industry Standard**: Used by all tech companies
- ✅ **Academic Requirement**: For project submission
- ✅ **Portfolio Building**: Show technical skills
- ✅ **Collaboration**: Work with other developers

### **What This Demonstrates**
- 🔧 **Technical Skills**: Command-line proficiency
- 🏗️ **Development Environment**: Professional setup
- 📚 **Self-Learning**: Installing development tools
- 🚀 **Problem Solving**: Troubleshooting installation issues

---

## 📞 **Help and Support**

### **Official Resources**
- **Git Documentation**: https://git-scm.com/doc
- **Git for Windows**: https://gitforwindows.org/
- **GitHub Support**: https://support.github.com/
- **Stack Overflow**: https://stackoverflow.com/questions/tagged/git

### **Video Tutorials**
- **Git for Windows Tutorial**: Search YouTube
- **GitHub Desktop Tutorial**: Official GitHub videos
- **Git Basics**: FreeCodeCamp, Traversy Media

---

## 🚀 **Next Steps**

### **After Git Installation**
1. **Verify installation**: `git --version`
2. **Configure Git**: Set name and email
3. **Test with project**: Run upload script
4. **Upload to GitHub**: Complete the process
5. **Verify repository**: Check online

### **Quick Commands Reference**
```bash
# Check version
git --version

# Configure user
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Initialize repository
git init

# Add files
git add .

# Commit changes
git commit -m "Your message"

# Push to GitHub
git push origin main
```

---

**Prepared by**: Divya.V, II MSc Computer Science  
**Institution**: Gobi Arts and Science College (Autonomous)  
**Date**: March 8, 2026

*This guide provides multiple methods for installing Git on Windows, ensuring you can successfully upload your project to GitHub.*
