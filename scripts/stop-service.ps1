# SWE-Pruner Windows 快捷停止脚本
# 用途：在 Windows PowerShell 中一键停止 SWE-Pruner（释放 GPU）

Write-Host "🛑 停止 SWE-Pruner 服务..." -ForegroundColor Yellow

# 在 WSL2 中执行停止脚本
wsl -d Ubuntu-22.04 -- bash /mnt/d/swe-pruner-workspace/stop-swe-pruner.sh

Write-Host ""
Write-Host "✅ GPU 资源已释放，可以开始游戏了！" -ForegroundColor Green
