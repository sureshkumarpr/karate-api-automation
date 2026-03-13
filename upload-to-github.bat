@echo off
echo 🚀 GitHub Upload Script for E-commerce API Test Automation Suite
echo =============================================================
echo Author: Divya.V, II MSc Computer Science, Gobi Arts and Science College (Autonomous)
echo Target Repository: https://github.com/divya131203/karate-api-automation
echo.

cd /d "c:/Users/Suresh Kumar PR/Documents/Divya_Project"

echo 📋 Step 1: Checking current directory...
echo Current directory: %CD%
echo.

echo 📁 Step 2: Listing files to be uploaded...
dir /a
echo.

echo 🔧 Step 3: Initializing Git repository...
git init
if %errorlevel% neq 0 (
    echo ❌ Git initialization failed. Please install Git first.
    goto :error
)
echo ✅ Git repository initialized
echo.

echo 🔗 Step 4: Adding remote repository...
git remote add origin https://github.com/divya131203/karate-api-automation.git
echo ✅ Remote repository added
echo.

echo 📝 Step 5: Creating .gitignore file...
echo # Maven > .gitignore
echo target/ >> .gitignore
echo !.mvn/wrapper/maven-wrapper.jar >> .gitignore
echo !**/src/main/**/target/ >> .gitignore
echo !**/src/test/**/target/ >> .gitignore
echo. >> .gitignore
echo # IDE >> .gitignore
echo .idea/ >> .gitignore
echo *.iws >> .gitignore
echo *.iml >> .gitignore
echo *.ipr >> .gitignore
echo .vscode/ >> .gitignore
echo. >> .gitignore
echo # OS >> .gitignore
echo .DS_Store >> .gitignore
echo Thumbs.db >> .gitignore
echo. >> .gitignore
echo # Logs >> .gitignore
echo *.log >> .gitignore
echo. >> .gitignore
echo # Temporary files >> .gitignore
echo *.tmp >> .gitignore
echo *.temp >> .gitignore
echo ✅ .gitignore file created
echo.

echo 📦 Step 6: Adding all files to Git...
git add .
if %errorlevel% neq 0 (
    echo ❌ Failed to add files to Git.
    goto :error
)
echo ✅ Files added to Git staging area
echo.

echo 📊 Step 7: Checking Git status...
git status
echo.

echo 💾 Step 8: Committing files...
git commit -m "Initial commit: Complete E-commerce API Test Automation Suite

🚀 Features:
- Comprehensive API testing with Karate 1.4.0
- 52 test scenarios across 4 modules
- Performance testing with Gatling integration
- CI/CD pipeline with GitHub Actions
- Interactive HTML reports
- Complete documentation

📁 Structure:
- Authentication tests (login, registration, token management)
- Product catalog tests (search, filtering, CRUD operations)
- Shopping cart tests (add, update, remove items)
- Checkout & order tests (payment processing, order tracking)
- Performance tests (load testing with 50+ concurrent users)

🎯 Author:
Divya.V, II MSc Computer Science
Gobi Arts and Science College (Autonomous)
Gobichettipalayam, Erode District, Pin 638458

📚 Documentation:
- Complete API documentation
- Test execution guide
- Software version requirements
- Online setup guide
- Presentation materials"
if %errorlevel% neq 0 (
    echo ❌ Failed to commit files.
    goto :error
)
echo ✅ Files committed successfully
echo.

echo 🚀 Step 9: Pushing to GitHub...
echo 📝 Note: If prompted for credentials:
echo    Username: divya131203
echo    Password: Your GitHub Personal Access Token (not your password)
echo.
echo 🔑 To create Personal Access Token:
echo    1. Go to GitHub → Settings → Developer settings → Personal access tokens
echo    2. Generate new token with 'repo' scope
echo    3. Copy token and use as password
echo.
git push -u origin main
if %errorlevel% neq 0 (
    echo ❌ Failed to push to GitHub.
    echo.
    echo 🔧 Trying alternative approach...
    git branch -M main
    git push -u origin main
    if %errorlevel% neq 0 (
        echo ❌ Push failed. Please check:
        echo    1. Repository exists at: https://github.com/divya131203/karate-api-automation
        echo    2. You have created Personal Access Token
        echo    3. Network connection is stable
        goto :error
    )
)
echo ✅ Successfully pushed to GitHub!
echo.

echo 🔍 Step 10: Verifying upload...
echo.
echo 📂 Your repository is now available at:
echo    https://github.com/divya131203/karate-api-automation
echo.
echo 📋 What to check:
echo    ✅ All files are visible
echo    ✅ README.md displays correctly
echo    ✅ File structure is maintained
echo    ✅ Documentation links work
echo.
echo 🌐 Optional: Enable GitHub Pages
echo    1. Go to repository Settings
echo    2. Scroll to GitHub Pages
echo    3. Source: Deploy from branch 'main'
echo    4. Your site will be at: https://divya131203.github.io/karate-api-automation/
echo.

goto :success

:error
echo.
echo ❌ Upload failed. Please check:
echo    1. Git is installed (git --version)
echo    2. Network connection is stable
echo    3. Repository exists on GitHub
echo    4. You have valid GitHub credentials
echo    5. Personal Access Token has 'repo' scope
echo.
echo 📞 For help, check: GITHUB_UPLOAD_GUIDE.md
pause
exit /b 1

:success
echo.
echo 🎉 Upload completed successfully!
echo.
echo 📊 Repository Statistics:
echo    📁 Files uploaded: All project files
echo    📚 Documentation: Complete guides included
echo    🎯 Author: Divya.V, II MSc Computer Science
echo    🏫 Institution: Gobi Arts and Science College (Autonomous)
echo.
echo 🚀 Next steps:
echo    1. Visit: https://github.com/divya131203/karate-api-automation
echo    2. Verify all files are present
echo    3. Enable GitHub Pages (optional)
echo    4. Share repository with evaluators
echo.
echo ✅ Your E-commerce API Test Automation Suite is now live on GitHub!
echo.
pause
