---

## 🆕 Kubernetes Cluster Analysis Tool

A complete Kubernetes cluster analysis tool with Claude AI-powered diagnostics and professional HTML reporting.

### Quick Start

```bash
# Extract archive
tar -xzf k8s-cluster-analyzer-v1.0.tar.gz
cd k8s-cluster-analyzer

# Setup
python -m venv venv
source venv/bin/activate  # or venv\Scripts\activate on Windows
pip install -r requirements.txt

# Configure
cp .env.example .env
# Edit .env with CLAUDE_API_KEY and Azure credentials

# Run
python run_cluster_analysis.py cluster-id namespace pod-name
