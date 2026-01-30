# Troubleshooting Guide

## Common Issues

### 1. Service Not Running

**Symptom:** `Cannot connect to SWE-Pruner service`

**Solutions:**

```powershell
# Check if service is running
.\scripts\check-service.ps1

# If not running, start it
.\scripts\start-service.ps1

# Wait 30 seconds for startup
Start-Sleep -Seconds 30

# Verify
Invoke-WebRequest -Uri "http://localhost:8000"
```

### 2. Network Connection Failed

**Symptom:** `Network is unreachable` or `Connection refused`

**Solutions:**

```powershell
# 1. Check WSL2 network configuration
cat C:\Users\bob_c\.wslconfig

# Should contain:
# [wsl2]
# networkingMode=mirrored

# 2. Restart WSL2
wsl --shutdown
wsl -d Ubuntu-22.04

# 3. Test connectivity
wsl -d Ubuntu-22.04 -- curl -I https://huggingface.co
```

### 3. Model Loading Failed

**Symptom:** `Model not found` or `Invalid model path`

**Solutions:**

```powershell
# Verify model files exist
wsl -d Ubuntu-22.04 -- ls -lh /mnt/d/swe-pruner-workspace/swe-pruner/swe-pruner/model/

# Should show:
# - model.safetensors (1.3 GB)
# - tokenizer.json (11 MB)
# - vocab.json (2.7 MB)
# - config.json, etc.

# If files are missing or are LFS pointers (< 1 KB), re-download
.\scripts\download-model.ps1
```

### 4. GPU Not Detected

**Symptom:** Service runs but uses CPU (slow)

**Solutions:**

```bash
# Check NVIDIA driver
wsl -d Ubuntu-22.04 -- nvidia-smi

# Check CUDA availability
wsl -d Ubuntu-22.04 -- python -c "import torch; print(f'CUDA available: {torch.cuda.is_available()}')"

# If CUDA not available, reinstall PyTorch
wsl -d Ubuntu-22.04 -- bash -c "cd /mnt/d/swe-pruner-workspace/swe-pruner/swe-pruner && ~/.local/bin/uv pip install torch torchvision --index-url https://download.pytorch.org/whl/cu121"
```

### 5. Slow Response Time

**Symptom:** Requests take > 5 seconds

**Possible Causes:**

1. **First request** - Model loading (~2-3 seconds)
2. **Large code files** - > 5000 lines
3. **CPU mode** - GPU not available
4. **Multiple concurrent requests**

**Solutions:**

```python
# 1. Pre-warm the service
prune_code("def test(): pass", "test")

# 2. Split large files
if len(code) > 5000:
    # Process in chunks
    pass

# 3. Check GPU usage
# wsl -d Ubuntu-22.04 -- nvidia-smi
```

### 6. Out of Memory

**Symptom:** Service crashes or returns 500 error

**Solutions:**

```powershell
# 1. Stop other GPU applications
.\scripts\stop-service.ps1

# 2. Close games/GPU-intensive apps

# 3. Restart service
.\scripts\start-service.ps1

# 4. Check GPU memory
wsl -d Ubuntu-22.04 -- nvidia-smi
```

### 7. Invalid JSON Response

**Symptom:** `Invalid JSON response from service`

**Solutions:**

```powershell
# Check service logs
wsl -d Ubuntu-22.04 -- tail -n 100 /tmp/swe-pruner.log

# Look for errors like:
# - Syntax errors
# - Model loading failures
# - CUDA errors

# Restart service
.\scripts\stop-service.ps1
.\scripts\start-service.ps1
```

### 8. Permission Denied

**Symptom:** Cannot write to log file or PID file

**Solutions:**

```bash
# Fix permissions
wsl -d Ubuntu-22.04 -- sudo chmod 777 /tmp

# Or run as root (already default in our setup)
wsl -d Ubuntu-22.04 -- whoami  # Should show 'root'
```

## Diagnostic Commands

### Check Service Health

```powershell
# PowerShell
Invoke-WebRequest -Uri "http://localhost:8000" -TimeoutSec 5

# Python
python -c "from tools.prune_code import check_service_health; print(check_service_health())"
```

### View Service Logs

```powershell
# Last 50 lines
wsl -d Ubuntu-22.04 -- tail -n 50 /tmp/swe-pruner.log

# Follow logs in real-time
wsl -d Ubuntu-22.04 -- tail -f /tmp/swe-pruner.log
```

### Check Process

```powershell
# Find SWE-Pruner process
wsl -d Ubuntu-22.04 -- ps aux | grep swe-pruner

# Check PID file
wsl -d Ubuntu-22.04 -- cat /tmp/swe-pruner.pid
```

### Test API Manually

```powershell
$body = @{code='def test(): pass'; query='test'} | ConvertTo-Json
Invoke-WebRequest -Uri 'http://localhost:8000/prune' -Method POST -Body $body -ContentType 'application/json'
```

## Error Messages Reference

| Error Message | Cause | Solution |
|---------------|-------|----------|
| `Network is unreachable` | WSL2 network issue | Configure mirrored networking |
| `Connection refused` | Service not running | Start service |
| `Model not found` | Missing model files | Download model |
| `CUDA out of memory` | GPU memory full | Close other GPU apps |
| `Invalid JSON` | Service error | Check logs, restart |
| `Timeout` | Service overloaded | Reduce concurrent requests |

## Getting Help

If issues persist:

1. **Collect diagnostic info:**

   ```powershell
   .\scripts\check-service.ps1 > diagnostic.txt
   wsl -d Ubuntu-22.04 -- tail -n 100 /tmp/swe-pruner.log >> diagnostic.txt
   wsl -d Ubuntu-22.04 -- nvidia-smi >> diagnostic.txt
   ```

2. **Check deployment documentation:**
   - [docs/deployment.md](deployment.md)
   - [docs/configuration.md](configuration.md)

3. **Review SWE-Pruner repository:**
   - <https://github.com/ayanami-kitasan/code-pruner>
