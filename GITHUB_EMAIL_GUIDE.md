# GitHub Deployment & Email Sharing Guide

## 🚀 Two Ways to Share Your Report

### Option 1: GitHub Pages (Recommended)
**Deploy report to GitHub and share permanent URL**

```batch
github-deploy.bat
```

**Your manager will access:**
```
https://sureshkumarpr.github.io/karate-api-automation/karate-summary.html
```

---

### Option 2: Email with Local Server
**Start local server and email URL to manager**

```batch
send-email.bat
```

**Your manager will access:**
```
http://192.168.31.186:8080/karate-summary.html
```

---

## 📋 Step-by-Step Instructions

### GitHub Deployment (Option 1)

1. **Prerequisites**:
   - Git installed on your system
   - GitHub account with repository access

2. **Run Deployment**:
   ```batch
   github-deploy.bat
   ```

3. **Enable GitHub Pages** (one-time setup):
   - Go to: https://github.com/sureshkumarpr/karate-api-automation/settings/pages
   - Source: Deploy from a branch
   - Branch: main
   - Folder: /root
   - Save

4. **Share URL**:
   ```
   https://sureshkumarpr.github.io/karate-api-automation/karate-summary.html
   ```

### Email Sharing (Option 2)

1. **Start Local Server**:
   ```batch
   FINAL-SERVER.bat
   ```

2. **Send Email** (in another terminal):
   ```batch
   send-email.bat
   ```

3. **Enter Email Details**:
   - Manager's email: manager@company.com
   - Your email: your-email@company.com
   - Gmail credentials (if using Gmail)

4. **Manager Receives**:
   - Professional HTML email
   - Direct link to report
   - Test summary

---

## 🔧 Configuration Required

### For GitHub Deployment:
- Git installed: https://git-scm.com/download/win
- Repository access: sureshkumarpr/karate-api-automation

### For Email Sending:
- Gmail account with "Less secure apps" enabled
- OR App Password for Gmail
- SMTP access through firewall

---

## 📧 Email Template Preview

Your manager will receive a professional email with:

- ✅ **Subject**: "🚀 Karate API Test Report Available"
- 📊 **Report Summary**: 47 passed, 3 failed, 94% success rate
- 🔗 **Direct Link**: Click-to-view button
- 🎨 **Professional Design**: HTML formatted email
- 📱 **Mobile Friendly**: Works on all devices

---

## 🌐 URL Comparison

| Method | URL | Access | Duration |
|--------|-----|--------|----------|
| GitHub Pages | `https://sureshkumarpr.github.io/...` | Global | Permanent |
| Local Server | `http://192.168.31.186:8080/...` | Local Network | While server runs |
| Email | Link in email | Anywhere | Instant |

---

## 🎯 Recommended Workflow

### For Regular Sharing:
1. **Use GitHub Pages** for permanent access
2. **Update report** by running `github-deploy.bat`
3. **Share same URL** with manager every time

### For Quick Sharing:
1. **Use email method** for immediate access
2. **Local server** provides real-time updates
3. **Email notification** delivers link instantly

---

## 🛠️ Troubleshooting

### GitHub Issues:
- **Push failed**: Check repository access
- **Pages not working**: Enable GitHub Pages in settings
- **404 error**: Wait 2-5 minutes for deployment

### Email Issues:
- **Authentication failed**: Enable less secure apps in Gmail
- **SMTP blocked**: Check firewall settings
- **Email not received**: Check spam folder

---

## 📞 Support

### Quick Commands:
```batch
# Deploy to GitHub
github-deploy.bat

# Send email
send-email.bat

# Start local server
FINAL-SERVER.bat

# Generate report only
generate-report.bat
```

### Files Created:
- `github-deploy.bat` - GitHub deployment
- `send-email.bat` - Email sender
- `email-report.ps1` - Email PowerShell script
- `github-web-server.yml` - GitHub Actions workflow

---

**Choose the method that works best for your team!**
