# Configuration Guide

## Service Configuration

### Port Configuration

Default port: `8000`

To change the port, edit `scripts/start-service.ps1`:

```bash
# Line 22-24
nohup ~/.local/bin/uv run swe-pruner --model-path ./model --port 8080 > /tmp/swe-pruner.log 2>&1 &
```

### Model Path

Default: `./model` (relative to SWE-Pruner installation)

Absolute path: `D:\swe-pruner-workspace\swe-pruner\swe-pruner\model`

### WSL2 Network Configuration

File: `C:\Users\bob_c\.wslconfig`

```ini
[wsl2]
# Mirror Windows network (required for Clash proxy)
networkingMode=mirrored

# DNS tunneling for better compatibility
dnsTunneling=true

# Auto-proxy configuration
autoProxy=true

# Firewall settings
firewall=true
```

**Apply changes:**

```powershell
wsl --shutdown
```

## Python Tool Configuration

### Service URL

Default: `http://localhost:8000/prune`

To use a different endpoint:

```python
from tools.prune_code import prune_code

result = prune_code(
    code=code,
    query=query,
    service_url="http://localhost:8080/prune"  # Custom port
)
```

### Timeout

Default: 30 seconds

```python
result = prune_code(
    code=code,
    query=query,
    timeout=60  # Longer timeout for large files
)
```

### Threshold

Default: 0.7 (70% relevance)

```python
# Aggressive pruning (more reduction, less accuracy)
result = prune_code(code, query, threshold=0.5)

# Conservative pruning (less reduction, higher accuracy)
result = prune_code(code, query, threshold=0.9)
```

## Performance Tuning

### GPU Memory

Default: ~2 GB

To reduce memory usage, consider:

- Stopping other GPU applications
- Using smaller batch sizes (if implementing batch processing)

### Response Time

Typical: < 1 second

Factors affecting speed:

- Code size (larger = slower)
- GPU availability
- First request (model loading: ~2-3 seconds)

### Concurrent Requests

The service can handle multiple concurrent requests, but performance may degrade with:
>
- > 5 concurrent requests
- Very large code files (> 10,000 lines)

## Logging

### Service Logs

Location: `/tmp/swe-pruner.log` (in WSL2)

View logs:

```powershell
wsl -d Ubuntu-22.04 -- tail -f /tmp/swe-pruner.log
```

### Application Logs

To add logging to your application:

```python
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

result = prune_code(code, query)
logger.info(f"Pruned code: {result['reduction_rate']:.1f}% reduction")
```

## Environment Variables

### Offline Mode

If you need to run completely offline:

```bash
export HF_HUB_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
```

Note: This requires all models to be pre-downloaded.

### CUDA Configuration

Default: Uses available GPU

To force CPU mode (slower):

```bash
export CUDA_VISIBLE_DEVICES=""
```

## Advanced Configuration

### Custom Model

To use a different model:

1. Download model to custom location
2. Update `scripts/start-service.ps1`:

```bash
nohup ~/.local/bin/uv run swe-pruner --model-path /path/to/custom/model --port 8000 > /tmp/swe-pruner.log 2>&1 &
```

### API Rate Limiting

Currently no rate limiting. To add:

1. Use a reverse proxy (nginx)
2. Configure rate limits
3. Update service URL in tool configuration

## Troubleshooting Configuration

### Service Won't Start

Check configuration:

```powershell
# Verify WSL2 config
cat C:\Users\bob_c\.wslconfig

# Check model path
wsl -d Ubuntu-22.04 -- ls -lh /mnt/d/swe-pruner-workspace/swe-pruner/swe-pruner/model/
```

### Network Issues

Verify proxy settings:

```powershell
# Check Windows proxy
netsh winhttp show proxy

# Test WSL2 connectivity
wsl -d Ubuntu-22.04 -- curl -I https://huggingface.co
```

### GPU Not Detected

```bash
# Check CUDA
wsl -d Ubuntu-22.04 -- nvidia-smi

# Verify PyTorch CUDA
wsl -d Ubuntu-22.04 -- python -c "import torch; print(torch.cuda.is_available())"
```
