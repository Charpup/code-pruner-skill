# GitHub 手动部署指南

由于 GitHub API 权限限制，请按以下步骤手动创建仓库并推送代码。

## 步骤 1：在 GitHub 创建仓库

1. 访问 <https://github.com/new>
2. 填写仓库信息：
   - **Repository name**: `code-pruner-skill`
   - **Description**: `使用 SWE-Pruner 为 Antigravity IDE 提供智能代码上下文裁剪的 Skill`
   - **Visibility**: Public
   - **Initialize**: 不要勾选任何初始化选项（README, .gitignore, license）

3. 点击 **Create repository**

## 步骤 2：推送本地代码

在 PowerShell 中执行：

```powershell
cd C:\Users\bob_c\.gemini\antigravity\playground\code-pruner-skill

# 推送到 GitHub
git push -u origin main
```

## 步骤 3：添加仓库主题

在 GitHub 仓库页面：

1. 点击右侧的 ⚙️ **Settings**
2. 在 **Topics** 部分添加：
   - `antigravity`
   - `code-pruning`
   - `swe-pruner`
   - `llm-optimization`
   - `skill`

## 步骤 4：验证

访问 <https://github.com/Charpup/code-pruner-skill> 确认：

- ✅ README.md 正确显示
- ✅ 徽章正常渲染
- ✅ 文件结构完整
- ✅ LICENSE 文件存在

## 完成

仓库已成功部署到 GitHub。

## 后续步骤

### 可选：添加 GitHub Actions

创建 `.github/workflows/lint.yml` 用于自动化检查：

```yaml
name: Lint

on: [push, pull_request]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-python@v4
        with:
          python-version: '3.12'
      - run: pip install ruff
      - run: ruff check tools/
```

### 可选：添加 README 徽章

在 README.md 顶部已包含：

- MIT License 徽章
- Python 版本徽章
- SWE-Pruner 徽章

可以添加更多：

```markdown
[![GitHub Stars](https://img.shields.io/github/stars/Charpup/code-pruner-skill)](https://github.com/Charpup/code-pruner-skill/stargazers)
[![GitHub Issues](https://img.shields.io/github/issues/Charpup/code-pruner-skill)](https://github.com/Charpup/code-pruner-skill/issues)
```
