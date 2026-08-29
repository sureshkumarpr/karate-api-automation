# TROUBLESHOOTING GUIDE
## Common Issues & Wibey CLI Fixes

**Purpose**: Quick fixes if you encounter problems using the toolkit  
**For**: Sureshkumar @ TCS  
**Last Updated**: 2024-08-29

---

## TABLE OF CONTENTS

1. [Wibey CLI Connection Issues](#wibey-cli-connection-issues)
2. [Template-Related Issues](#template-related-issues)
3. [Kubernetes Access Issues](#kubernetes-access-issues)
4. [Claude Response Issues](#claude-response-issues)
5. [Quick Diagnostic Commands](#quick-diagnostic-commands)
6. [Getting Help from Claude](#getting-help-from-claude)

---

## WIBEY CLI CONNECTION ISSUES

### Issue 1: "wibey: command not found"

**Symptom:**
```
$ wibey chat --model sonnet "Hello"
-bash: wibey: command not found
```

**Fix:**

#### Option 1: Check if Wibey is in PATH
```bash
# Find Wibey
which wibey
# If nothing shows, it's not installed or not in PATH

# Check common locations
ls -la /usr/local/bin/wibey
ls -la ~/bin/wibey
ls -la ~/.local/bin/wibey
```

#### Option 2: Add Wibey to PATH
```bash
# If Wibey is installed but not in PATH
export PATH=$PATH:/path/to/wibey/bin

# Make permanent by adding to ~/.bashrc or ~/.zshrc
echo 'export PATH=$PATH:/path/to/wibey/bin' >> ~/.bashrc
source ~/.bashrc
```

#### Option 3: Contact TCS Admin
```bash
# If Wibey is not installed
# Contact your TCS administrator
# They need to: apt install wibey (or similar)

# Verify with:
wibey --version
# Expected output: Wibey CLI version X.X.X
```

**Wibey CLI Fix:**
```bash
wibey chat --model sonnet "
I'm getting 'wibey: command not found' error.

Where is Wibey installed on my system?
How do I add it to PATH?
"
```

---

### Issue 2: "Connection refused" or "Connection timeout"

**Symptom:**
```
$ wibey chat --model sonnet "Hello"
Error: Connection refused
Error: Unable to connect to Anthropic API
```

**Fix:**

#### Option 1: Check Internet Connection
```bash
# Test basic connectivity
ping google.com
# Expected: bytes from..., time=X ms

# If ping fails, check your network
ipconfig (Windows)
ifconfig (Mac/Linux)
```

#### Option 2: Check Firewall
```bash
# Try with explicit proxy (if your company uses one)
wibey chat --model sonnet --proxy "http://proxy-server:port" "Hello"

# Or configure environment variable
export HTTP_PROXY=http://proxy-server:port
export HTTPS_PROXY=http://proxy-server:port
wibey chat --model sonnet "Hello"
```

#### Option 3: Try Different Model/Endpoint
```bash
# If Sonnet times out, try Haiku (faster)
wibey chat --model haiku "Quick test"

# If that works, use Haiku for quick checks
# Sonnet might be under heavy load
```

#### Option 4: Check Anthropic API Status
```bash
# Visit: https://status.anthropic.com/
# Check if there are any service interruptions

# Or ask Claude via Wibey if it's up
wibey chat --model haiku "Are you responding?"
```

**Wibey CLI Fix:**
```bash
wibey chat --model haiku "
I'm getting 'Connection refused' when trying to use Claude.

Am I experiencing:
1. A network issue?
2. Firewall blocking?
3. Anthropic API down?

How do I diagnose?
"
```

---

### Issue 3: "Authentication failed" or "Invalid API key"

**Symptom:**
```
$ wibey chat --model sonnet "Hello"
Error: Authentication failed
Error: Invalid API key
```

**Fix:**

#### Option 1: Check API Key
```bash
# Verify environment variable is set
echo $ANTHROPIC_API_KEY
# Should output: sk-ant-...(long string)

# If empty, it's not set
# If shows: wrong key or not configured
```

#### Option 2: Set API Key
```bash
# If key is not set
export ANTHROPIC_API_KEY="your-actual-key-here"

# Make permanent
echo 'export ANTHROPIC_API_KEY="your-key"' >> ~/.bashrc
source ~/.bashrc
```

#### Option 3: Login to Wibey
```bash
# If Wibey has a login command
wibey login
# Follow prompts to authenticate

# Verify it worked
wibey chat --model haiku "Hello"
```

#### Option 4: Check Key Validity
```bash
# Test with simplest possible request
wibey chat --model haiku "1+1"

# If still fails, key might be expired/invalid
# Contact: TCS Wibey administrator
```

**Wibey CLI Fix:**
```bash
wibey chat --model sonnet "
I'm getting 'Authentication failed' error.

How do I:
1. Check if my API key is configured?
2. Set the API key?
3. Verify the key is valid?
4. Where do I get a new key?
"
```

---

## TEMPLATE-RELATED ISSUES

### Issue 4: "File not found" when opening template

**Symptom:**
```bash
$ cat incident-management/templates/TEMPLATE_1_K8S_POD_CRASH.txt
cat: incident-management/templates/TEMPLATE_1_K8S_POD_CRASH.txt: No such file or directory
```

**Fix:**

#### Option 1: Check You're in Right Directory
```bash
# Current directory
pwd
# Should show: /path/to/claude-incident-toolkit

# List contents
ls -la
# Should show: incident-management/, ai-tools/, README.md

# If not, navigate to toolkit
cd ~/Downloads/claude-incident-toolkit
# or wherever you extracted it
```

#### Option 2: Check File Exists
```bash
# List templates
ls -la incident-management/templates/
# Should show: TEMPLATE_1_K8S_POD_CRASH.txt, etc.

# If not, toolkit might not be extracted properly
unzip claude-incident-toolkit.zip
```

#### Option 3: Use Absolute Path
```bash
# Use full path instead of relative
cat ~/Downloads/claude-incident-toolkit/incident-management/templates/TEMPLATE_1_K8S_POD_CRASH.txt
```

#### Option 4: Create Alias (Permanent Fix)
```bash
# Add to ~/.bashrc
alias toolkit="cd /path/to/claude-incident-toolkit"

# Then use
toolkit
cat incident-management/templates/TEMPLATE_1_K8S_POD_CRASH.txt
```

**Wibey CLI Fix:**
```bash
wibey chat --model sonnet "
I'm getting 'File not found' error for TEMPLATE_1.

Expected path: incident-management/templates/TEMPLATE_1_K8S_POD_CRASH.txt

How do I:
1. Find where the toolkit is extracted?
2. Use correct file paths?
3. Create aliases for quick access?
"
```

---

### Issue 5: Template content is empty or cut off

**Symptom:**
```bash
$ cat incident-management/templates/TEMPLATE_1.txt | wibey chat --model sonnet
# Response is incomplete or template content missing
```

**Fix:**

#### Option 1: Check Template File
```bash
# View file size
ls -lh incident-management/templates/TEMPLATE_1_K8S_POD_CRASH.txt
# Should show: around 2K

# View entire content
cat incident-management/templates/TEMPLATE_1_K8S_POD_CRASH.txt | wc -l
# Should show: 40+ lines

# If smaller, file might be corrupted
```

#### Option 2: Read Template First
```bash
# Read locally first
cat incident-management/templates/TEMPLATE_1_K8S_POD_CRASH.txt

# If looks good, then pipe to Wibey
cat incident-management/templates/TEMPLATE_1_K8S_POD_CRASH.txt | wibey chat --model sonnet
```

#### Option 3: Use Full Template + Your Data
```bash
# Instead of piping, create merged file
cat > /tmp/full_incident.txt << 'EOF'
$(cat incident-management/templates/TEMPLATE_1_K8S_POD_CRASH.txt)

# Your specific data:
Pod name: payment-service-5f7d9c
Error: [paste exact error]
EOF

# Send merged file
wibey chat --model sonnet "$(cat /tmp/full_incident.txt)"
```

#### Option 4: Check File Encoding
```bash
# Check file type
file incident-management/templates/TEMPLATE_1_K8S_POD_CRASH.txt
# Should show: ASCII text or UTF-8 Unicode text

# If binary or encoding issue, re-extract zip
```

**Wibey CLI Fix:**
```bash
wibey chat --model sonnet "
Template file seems empty or cut off.

Symptoms:
- File size is 0 or very small
- Missing content when I cat it
- Wibey response is incomplete

How do I:
1. Verify template file integrity?
2. Re-extract if corrupted?
3. Manually rebuild template?
"
```

---

## KUBERNETES ACCESS ISSUES

### Issue 6: "kubectl: command not found"

**Symptom:**
```bash
$ kubectl get pods -n production
-bash: kubectl: command not found
```

**Note**: This is not a Wibey issue, but you need kubectl to gather data for templates.

**Fix:**

#### Option 1: Check kubectl Installed
```bash
# Find kubectl
which kubectl
# If nothing shows, it's not installed

# Check version
kubectl version --client
# Should show: v1.27+
```

#### Option 2: Install kubectl
```bash
# Using package manager (Linux)
sudo apt-get install kubectl

# Or download directly
# Visit: https://kubernetes.io/docs/tasks/tools/
```

#### Option 3: Configure kubeconfig
```bash
# Check kubeconfig
kubectl config current-context
# Should show: your-cluster-name

# If not set up
# Get kubeconfig from Azure:
az aks get-credentials --resource-group myResourceGroup --name myCluster

# Or copy kubeconfig to ~/.kube/config
```

**Wibey CLI Fix:**
```bash
wibey chat --model sonnet "
I need to gather Kubernetes cluster data to use the incident templates.

How do I:
1. Install kubectl?
2. Configure access to my AKS cluster?
3. Verify connection to cluster?
4. Run basic kubectl commands?
"
```

---

### Issue 7: "The connection to server was refused"

**Symptom:**
```bash
$ kubectl get pods -n production
The connection to the server api-server.com:443 was refused
```

**Fix:**

#### Option 1: Check Cluster Access
```bash
# Verify cluster connection
kubectl cluster-info

# If connection refused, credentials might be expired
az aks get-credentials --resource-group myResourceGroup --name myCluster --overwrite-existing
```

#### Option 2: Check Kubeconfig
```bash
# View current context
kubectl config current-context

# List all contexts
kubectl config get-contexts

# Switch context if needed
kubectl config use-context desired-context
```

#### Option 3: Verify Credentials
```bash
# Check if credentials are valid
az account show

# If not authenticated to Azure
az login

# Then get AKS credentials
az aks get-credentials --resource-group myResourceGroup --name myCluster
```

**Wibey CLI Fix:**
```bash
wibey chat --model sonnet "
kubectl is showing 'connection refused' error.

I need access to AKS cluster for incident troubleshooting.

How do I:
1. Re-authenticate to Azure?
2. Refresh cluster credentials?
3. Verify cluster is accessible?
4. Troubleshoot kubeconfig?
"
```

---

## CLAUDE RESPONSE ISSUES

### Issue 8: Claude's answer is generic or not helpful

**Symptom:**
```
Claude's response doesn't address your specific issue.
Generic explanation that doesn't match your environment.
```

**Fix:**

#### Option 1: Provide More Context
```bash
# Resend with MORE specific information
wibey chat --model sonnet "
Previous issue: [what you described]

MORE SPECIFIC INFO:
- Exact error message (copy-paste): [error]
- What I've already tried:
  1. [attempt 1 - result]
  2. [attempt 2 - result]
- My environment:
  - Cluster version: [from kubectl version]
  - Pod image: [exact image]
  - Recent changes: [what changed]

Please address MY SPECIFIC situation, not generic solutions.
"
```

#### Option 2: Use Opus Model
```bash
# Sonnet is balanced, but Opus is more capable
wibey chat --model opus "
[Your complete issue with all details]

I need the MOST thorough analysis and detailed fix.
"
```

#### Option 3: Ask Claude to Explain
```bash
wibey chat --model sonnet "
Your previous suggestion was:
[what Claude said]

But in MY situation:
[your constraints]

Why might that suggestion not work for me?
What's a different approach?
"
```

**Wibey CLI Fix:**
```bash
wibey chat --model sonnet "
Claude's previous response was too generic.

My specific situation:
- Issue: [your exact issue]
- Environment: [your exact setup]
- Constraints: [what you can't do]

Give me specific guidance for MY exact situation, not generic.
"
```

---

### Issue 9: Claude asks for more information

**Symptom:**
```
Claude: Can you provide the exact error message?
Claude: What's the pod status?
Claude: When did this start?
```

**This is normal!** Claude is asking for information to help better.

**Fix:**

#### Provide the Information Claude Asks For
```bash
# Claude asked: "Can you provide the exact error message?"
# You should:

# Get the exact error
kubectl describe pod payment-service-xxx -n production | grep -A 5 "Status:"

# Then respond to Claude with exact output
wibey chat --model sonnet "
Pod status from kubectl describe:

Status:            ImagePullBackOff
Last Probe:        2024-08-29T14:23:04Z
  Reason:          ImagePullBackOff
  Message:         Back-off pulling image

Full error message:
Error response from daemon: unauthorized: authentication required

Now what's the fix?
"
```

#### Avoid Generic Responses
```bash
# DON'T say: "The pod is crashing"
# DO say: "ImagePullBackOff - Failed to pull image 'myacr.azurecr.io/payment-svc:1.2.3': 
           rpc error: code = Unknown desc = Error response from daemon: unauthorized"

# DON'T say: "Recently changed something"
# DO say: "Deployed new image version v2.5.1 2 hours ago at 14:00 UTC,
           previously v2.5.0 was working fine since 3 weeks"
```

**Reference**: Check `COMMON_CLAUDE_QUESTIONS_GUIDE.md` for common questions Claude asks and how to answer them.

---

## QUICK DIAGNOSTIC COMMANDS

### Self-Diagnose Issues

```bash
# 1. Check Wibey CLI
echo "=== Wibey CLI ==="
wibey --version
which wibey

# 2. Check kubectl
echo "=== Kubectl ==="
kubectl version --client
kubectl cluster-info

# 3. Check Kubernetes access
echo "=== K8s Access ==="
kubectl get nodes
kubectl get pods -A | head -10

# 4. Check toolkit
echo "=== Toolkit ==="
pwd
ls -la incident-management/templates/ | wc -l
# Should show: 7 templates

# 5. Quick test
echo "=== Test Wibey ==="
wibey chat --model haiku "Respond with OK if working"
```

**If all show OK → Toolkit is ready!**  
**If any fail → See relevant section above**

---

## GETTING HELP FROM CLAUDE

### When You're Stuck, Ask Claude!

```bash
# Generic toolkit question
wibey chat --model sonnet "
I'm using the Claude Incident Toolkit and need help.

Problem: [describe what's wrong]

Questions:
1. Which template should I use?
2. How do I troubleshoot this?
3. What am I missing?
4. Step-by-step guidance?
"
```

### Ask Claude About Wibey Issues

```bash
# Wibey configuration issue
wibey chat --model sonnet "
I have a Wibey CLI issue:

Error: [exact error message]
Command: [what I ran]

How do I:
1. Diagnose this issue?
2. Fix it?
3. Verify it's fixed?
"
```

### Ask Claude About Kubernetes

```bash
# Kubernetes access issue
wibey chat --model sonnet "
I can't access my Kubernetes cluster:

Error: [exact error]
Cluster: [AKS / GKE / etc]

How do I:
1. Get cluster access?
2. Configure kubeconfig?
3. Verify connection?
4. Troubleshoot?
"
```

---

## COMPLETE TROUBLESHOOTING TREE

```
START
  │
  ├─→ Can I run: wibey --version?
  │   ├─ NO  → Issue 1: Install/PATH fix
  │   └─ YES → Continue
  │
  ├─→ Can I connect: wibey chat --model haiku "Hello"?
  │   ├─ NO  → Issues 2-3: Network/Auth fixes
  │   └─ YES → Continue
  │
  ├─→ Can I access toolkit: ls incident-management/?
  │   ├─ NO  → Issue 4: Extract/Path fix
  │   └─ YES → Continue
  │
  ├─→ Can I access cluster: kubectl get pods?
  │   ├─ NO  → Issues 6-7: kubectl/kubeconfig fix
  │   └─ YES → Continue
  │
  ├─→ Fill template and send to Claude
  │   │
  │   ├─→ Response is generic?
  │   │   └─ YES → Issue 8: Provide more context
  │   │
  │   ├─→ Claude asks questions?
  │   │   └─ YES → Issue 9: Answer with specifics
  │   │
  │   └─→ Response is helpful?
  │       └─ YES → ✅ INCIDENT SOLVED!
  │
  └─→ STUCK? Ask Claude for help!
      wibey chat --model sonnet "[Your issue and questions]"
```

---

## KEY TAKEAWAYS

✅ **Most issues have simple fixes**
- Wibey not found? Install it
- Connection failed? Check internet
- File not found? Check directory
- Generic answer? Provide more context

✅ **When in doubt, ask Claude**
```bash
wibey chat --model sonnet "I'm stuck with [issue]. Help?"
```

✅ **Use kubectl to gather data**
```bash
kubectl get pods -n production
kubectl describe pod [name] -n [namespace]
kubectl logs [pod] -n [namespace] --tail=100
```

✅ **Exact information beats summaries**
- Copy-paste errors, don't paraphrase
- Include complete output
- Mention what you've tried

✅ **Reference the guides**
- `HOW_TO_USE_COMPLETE_GUIDE.md` - Usage instructions
- `COMMON_CLAUDE_QUESTIONS_GUIDE.md` - Claude Q&A patterns
- `TROUBLESHOOTING_GUIDE.md` - This file

---

## IF ALL ELSE FAILS

```bash
# Send everything to Claude with diagnostics
wibey chat --model opus "
I'm having trouble using the Claude Incident Toolkit.

My setup:
$(uname -a)
Wibey version: $(wibey --version 2>&1)
Kubectl version: $(kubectl version --client 2>&1)
Working directory: $(pwd)

Problem: [describe issue]
What I've tried: [list attempts]

Please help me troubleshoot.
"
```

Claude will help you get unstuck! 🚀

---

**Questions?** Check:
1. `HOW_TO_USE_COMPLETE_GUIDE.md` - Usage step-by-step
2. `COMMON_CLAUDE_QUESTIONS_GUIDE.md` - Claude's questions
3. `README.md` - Overview
4. **This file** - Troubleshooting

Or **ask Claude** - it's what you've got Wibey for! 😊
