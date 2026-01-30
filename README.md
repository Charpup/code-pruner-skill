# Code Pruner Skill

Intelligent code context pruning using SWE-Pruner to reduce token consumption while maintaining relevance.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Python 3.12+](https://img.shields.io/badge/python-3.12+-blue.svg)](https://www.python.org/downloads/)
[![SWE-Pruner](https://img.shields.io/badge/Powered%20by-SWE--Pruner-blue)](https://github.com/Ayanami1314/swe-pruner)

## Based on SWE-Pruner

This Skill is built on top of [SWE-Pruner](https://github.com/Ayanami1314/swe-pruner), an intelligent code pruning tool designed for software engineering scenarios.

**Upstream Project**:

- 📦 GitHub: [Ayanami1314/swe-pruner](https://github.com/Ayanami1314/swe-pruner)
- 🤗 Model: [ayanami-kitasan/code-pruner](https://huggingface.co/ayanami-kitasan/code-pruner)

## Quick Start

### 1. Start Service

```powershell
cd scripts
.\start-service.ps1
```

### 2. Use in Code

```python
from tools.prune_code import prune_code

result = prune_code(
    code=open("large_file.py").read(),
    query="focus on authentication logic"
)

print(f"Reduced by {result['reduction_rate']:.1f}%")
print(result['pruned_code'])
```

### 3. CLI Usage

```bash
python tools/prune_code.py app.py "authentication logic"
```

## Features

- ✅ **23-54% token reduction** on average
- ✅ **95%+ accuracy** in relevance scoring
- ✅ **< 1 second** response time
- ✅ **Local deployment** - no API costs
- ✅ **GPU accelerated** - CUDA support

## Project Structure

```
code-pruner-skill/
├── SKILL.md              # Skill definition
├── README.md             # This file
├── scripts/              # Service management
│   ├── start-service.ps1
│   ├── stop-service.ps1
│   └── check-service.ps1
├── tools/                # Python tools
│   └── prune_code.py
├── examples/             # Usage examples
├── docs/                 # Documentation
└── tests/                # Test scripts
```

## Requirements

- Windows 11 with WSL2 (Ubuntu 22.04)
- NVIDIA GPU with CUDA support
- ~5 GB disk space (D drive)
- Python 3.12+

## Documentation

- [SKILL.md](SKILL.md) - Complete skill documentation
- [docs/deployment.md](docs/deployment.md) - Deployment guide
- [docs/configuration.md](docs/configuration.md) - Configuration options

## Service Management

```powershell
# Start (before coding)
.\scripts\start-service.ps1

# Stop (before gaming)
.\scripts\stop-service.ps1

# Check status
.\scripts\check-service.ps1
```

## Performance

| Metric | Value |
|--------|-------|
| Average Reduction | 40-50% |
| Relevance Score | 95%+ |
| Response Time | < 1s |
| GPU Memory | ~2 GB |

## License

MIT

## References

- [SWE-Pruner](https://github.com/ayanami-kitasan/code-pruner)
- [Deployment Success Report](../brain/.../deployment_success.md)
