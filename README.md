# Code Pruner Skill

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Python 3.12+](https://img.shields.io/badge/python-3.12+-blue.svg)](https://www.python.org/downloads/)
[![SWE-Pruner](https://img.shields.io/badge/Powered%20by-SWE--Pruner-blue)](https://github.com/Ayanami1314/swe-pruner)

**[English](#english) | [中文](#中文)**

</div>

---

## English

### 🎯 What is Code Pruner Skill?

An intelligent code context pruning tool for **Antigravity IDE** that reduces LLM token consumption by **40-50%** while maintaining **95%+ accuracy**. Built on [SWE-Pruner](https://github.com/Ayanami1314/swe-pruner), it automatically removes irrelevant code based on your query, keeping only what matters.

### ✨ Key Features

| Feature | Description |
|---------|-------------|
| 🎯 **High Efficiency** | 40-50% average token reduction |
| ⚡ **Fast Response** | < 1 second processing time |
| 🔒 **100% Local** | No API costs, data stays private |
| 🎮 **GPU Friendly** | Manual stop before gaming to free GPU |
| 🤖 **Auto Management** | Service lifecycle automation |
| 📊 **High Accuracy** | 95%+ relevance scoring |

### 🚀 Quick Start

#### 1. Start Service

```powershell
cd scripts
.\start-service.ps1
```

#### 2. Use in Code

```python
from tools.prune_code import prune_code

result = prune_code(
    code=open("large_file.py").read(),
    query="focus on authentication logic"
)

print(f"Reduced by {result['reduction_rate']:.1f}%")
print(result['pruned_code'])
```

#### 3. CLI Usage

```bash
python tools/prune_code.py app.py "authentication logic"
```

### 📊 Performance Metrics

| Metric | Value |
|--------|-------|
| Average Reduction | 40-50% |
| Relevance Score | 95%+ |
| Response Time | < 1s |
| GPU Memory | ~2 GB |

### 🏗️ Architecture

```
Antigravity IDE
    ↓
Code Pruner Skill
    ↓
Service Manager (Auto Start/Stop)
    ↓
SWE-Pruner Service (FastAPI)
    ↓
ML Model (Qwen3-Reranker)
```

### 📚 Documentation

- [SKILL.md](SKILL.md) - Complete skill definition
- [docs/deployment.md](docs/deployment.md) - Deployment guide
- [docs/configuration.md](docs/configuration.md) - Configuration options
- [docs/troubleshooting.md](docs/troubleshooting.md) - Troubleshooting

### 🙏 Acknowledgments

This Skill is built on top of [SWE-Pruner](https://github.com/Ayanami1314/swe-pruner), an intelligent code pruning tool designed for software engineering scenarios.

**Upstream Project**:

- 📦 GitHub: [Ayanami1314/swe-pruner](https://github.com/Ayanami1314/swe-pruner)
- 🤗 Model: [ayanami-kitasan/code-pruner](https://huggingface.co/ayanami-kitasan/code-pruner)

### 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

## 中文

### 🎯 Code Pruner Skill 是什么？

为 **Antigravity IDE** 设计的智能代码上下文裁剪工具，在保持 **95%+ 准确率**的同时减少 **40-50%** 的 LLM token 消耗。基于 [SWE-Pruner](https://github.com/Ayanami1314/swe-pruner) 构建，根据您的查询自动移除无关代码，只保留相关内容。

### ✨ 核心特性

| 特性 | 说明 |
|------|------|
| 🎯 **高效裁剪** | 平均减少 40-50% token 使用 |
| ⚡ **快速响应** | < 1 秒处理时间 |
| 🔒 **完全本地** | 无 API 费用，数据不外传 |
| 🎮 **GPU 友好** | 游戏前手动停止释放 GPU |
| 🤖 **自动管理** | 服务生命周期自动化 |
| 📊 **高准确率** | 95%+ 相关性评分 |

### 🚀 快速开始

#### 1. 启动服务

```powershell
cd scripts
.\start-service.ps1
```

#### 2. 代码中使用

```python
from tools.prune_code import prune_code

result = prune_code(
    code=open("large_file.py").read(),
    query="聚焦于认证逻辑"
)

print(f"裁剪率: {result['reduction_rate']:.1f}%")
print(result['pruned_code'])
```

#### 3. 命令行使用

```bash
python tools/prune_code.py app.py "认证逻辑"
```

### 📊 性能指标

| 指标 | 数值 |
|------|------|
| 平均裁剪率 | 40-50% |
| 相关性评分 | 95%+ |
| 响应时间 | < 1 秒 |
| GPU 内存 | ~2 GB |

### 🏗️ 技术架构

```
Antigravity IDE
    ↓
Code Pruner Skill
    ↓
服务管理器（自动启停）
    ↓
SWE-Pruner 服务（FastAPI）
    ↓
ML 模型（Qwen3-Reranker）
```

### 📚 文档

- [SKILL.md](SKILL.md) - 完整 Skill 定义
- [docs/deployment.md](docs/deployment.md) - 部署指南
- [docs/configuration.md](docs/configuration.md) - 配置说明
- [docs/troubleshooting.md](docs/troubleshooting.md) - 故障排查

### 🙏 致谢

本 Skill 基于 [SWE-Pruner](https://github.com/Ayanami1314/swe-pruner) 构建，这是一个专为软件工程场景设计的智能代码裁剪工具。

**上游项目**：

- 📦 GitHub: [Ayanami1314/swe-pruner](https://github.com/Ayanami1314/swe-pruner)
- 🤗 模型: [ayanami-kitasan/code-pruner](https://huggingface.co/ayanami-kitasan/code-pruner)

### 📄 许可证

MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。

---

<details>
<summary><b>📖 For LLM Agents / LLM Agent 专用信息</b></summary>

## Agent Integration Guide

### Automatic Invocation Triggers

This skill should be invoked when:

- File size > 500 lines
- `grep_search` returns > 100 results
- User requests to "focus on" or "analyze" specific functionality
- Context optimization needed for large codebases

### Usage Pattern

```python
# 1. Check if service is running
from tools.service_manager import get_service_manager
manager = get_service_manager()

# 2. Prune code (service auto-starts if needed)
result = manager.prune_with_lifecycle(
    code=source_code,
    query=user_intent  # e.g., "authentication logic"
)

# 3. Use pruned code for analysis
analyze_code(result['pruned_code'])

# 4. Report savings
print(f"Token reduction: {result['reduction_rate']:.1f}%")
```

### Service Lifecycle

- **Auto-start**: Service starts automatically on first invocation
- **Running**: Stays active during coding sessions
- **Manual stop**: User can stop before gaming to free GPU

### Error Handling

```python
try:
    result = prune_code(code, query)
except CodePrunerError as e:
    # Fallback: use original code
    result = {'pruned_code': code}
```

### Performance Expectations

| Scenario | Expected Behavior |
|----------|-------------------|
| First call | ~2-3 seconds (includes service startup) |
| Subsequent calls | < 1 second |
| Large files (> 5000 lines) | May take 2-3 seconds |
| Service unavailable | Graceful fallback to original code |

### Integration Points

1. **Global Rule**: `.agent/rules/code_pruner_integration.md`
2. **Service Manager**: `tools/service_manager.py`
3. **Core Tool**: `tools/prune_code.py`

---

## Agent 集成指南

### 自动调用触发条件

以下情况应调用此 Skill：

- 文件大小 > 500 行
- `grep_search` 返回 > 100 个结果
- 用户要求"聚焦于"或"分析"特定功能
- 大型代码库需要上下文优化

### 使用模式

```python
# 1. 检查服务状态
from tools.service_manager import get_service_manager
manager = get_service_manager()

# 2. 裁剪代码（如需要会自动启动服务）
result = manager.prune_with_lifecycle(
    code=source_code,
    query=user_intent  # 例如："认证逻辑"
)

# 3. 使用裁剪后的代码进行分析
analyze_code(result['pruned_code'])

# 4. 报告节省情况
print(f"Token 减少: {result['reduction_rate']:.1f}%")
```

### 服务生命周期

- **自动启动**：首次调用时自动启动服务
- **运行中**：编码会话期间保持运行
- **手动停止**：用户可在游戏前停止以释放 GPU

### 错误处理

```python
try:
    result = prune_code(code, query)
except CodePrunerError as e:
    # 降级：使用原始代码
    result = {'pruned_code': code}
```

### 性能预期

| 场景 | 预期行为 |
|------|----------|
| 首次调用 | ~2-3 秒（包含服务启动） |
| 后续调用 | < 1 秒 |
| 大文件（> 5000 行） | 可能需要 2-3 秒 |
| 服务不可用 | 优雅降级到原始代码 |

### 集成点

1. **Global Rule**: `.agent/rules/code_pruner_integration.md`
2. **服务管理器**: `tools/service_manager.py`
3. **核心工具**: `tools/prune_code.py`

</details>

---

<div align="center">

**Made with ❤️ for Antigravity IDE**

[Report Bug](https://github.com/Charpup/code-pruner-skill/issues) · [Request Feature](https://github.com/Charpup/code-pruner-skill/issues)

</div>
