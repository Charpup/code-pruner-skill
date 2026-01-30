# SWE-Pruner Windows 快捷启动脚本
# 用途：在 Windows PowerShell 中一键启动 SWE-Pruner

Write-Host "🚀 启动 SWE-Pruner 服务..." -ForegroundColor Green

# 在 WSL2 中执行启动脚本
wsl -d Ubuntu-22.04 -- bash /mnt/d/swe-pruner-workspace/start-swe-pruner.sh

Write-Host ""
Write-Host "💡 提示：" -ForegroundColor Cyan
Write-Host "   查看状态: .\status-swe-pruner.ps1"
Write-Host "   停止服务: .\stop-swe-pruner.ps1"
Write-Host "   测试调用: Invoke-WebRequest http://localhost:8000/health"
