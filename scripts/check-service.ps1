# SWE-Pruner Windows 状态检查脚本
# 用途：在 Windows PowerShell 中查看服务状态

Write-Host "📊 SWE-Pruner 服务状态" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 在 WSL2 中执行状态检查
wsl -d Ubuntu-22.04 -- bash /mnt/d/swe-pruner-workspace/status-swe-pruner.sh
