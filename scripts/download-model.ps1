# SWE-Pruner 模型文件下载脚本（Windows PowerShell）
# 用途：从 HuggingFace 下载完整的模型文件

$modelUrl = "https://huggingface.co/ayanami-kitasan/code-pruner/resolve/main"
$downloadDir = "D:\swe-pruner-workspace\model-download"
$targetDir = "D:\swe-pruner-workspace\swe-pruner\swe-pruner\model"

# 创建下载目录
New-Item -ItemType Directory -Force -Path $downloadDir | Out-Null

Write-Host "📥 开始下载 SWE-Pruner 模型文件..." -ForegroundColor Green
Write-Host ""

# 需要下载的文件列表
$files = @(
    @{Name="model.safetensors"; Size="1.3 GB"; Required=$true},
    @{Name="tokenizer.json"; Size="2.7 MB"; Required=$true},
    @{Name="vocab.json"; Size="2.7 MB"; Required=$true},
    @{Name="merges.txt"; Size="1.6 MB"; Required=$true},
    @{Name="config.json"; Size="500 B"; Required=$true},
    @{Name="tokenizer_config.json"; Size="5 KB"; Required=$true},
    @{Name="special_tokens_map.json"; Size="600 B"; Required=$true},
    @{Name="added_tokens.json"; Size="700 B"; Required=$true},
    @{Name="chat_template.jinja"; Size="4 KB"; Required=$false},
    @{Name="README.md"; Size="24 B"; Required=$false}
)

$totalFiles = $files.Count
$currentFile = 0

foreach ($file in $files) {
    $currentFile++
    $fileName = $file.Name
    $fileSize = $file.Size
    $filePath = Join-Path $downloadDir $fileName
    
    Write-Host "[$currentFile/$totalFiles] 下载 $fileName ($fileSize)..." -ForegroundColor Cyan
    
    try {
        $url = "$modelUrl/$fileName"
        Invoke-WebRequest -Uri $url -OutFile $filePath -TimeoutSec 300
        Write-Host "  ✅ 完成" -ForegroundColor Green
    }
    catch {
        if ($file.Required) {
            Write-Host "  ❌ 失败: $_" -ForegroundColor Red
            Write-Host ""
            Write-Host "请手动下载此文件：" -ForegroundColor Yellow
            Write-Host "  URL: $url"
            Write-Host "  保存到: $filePath"
            Write-Host ""
        }
        else {
            Write-Host "  ⚠️  跳过（非必需）" -ForegroundColor Yellow
        }
    }
}

Write-Host ""
Write-Host "📦 复制文件到模型目录..." -ForegroundColor Green

# 复制文件到目标目录
Copy-Item "$downloadDir\*" $targetDir -Force

Write-Host ""
Write-Host "✅ 模型文件下载完成！" -ForegroundColor Green
Write-Host ""
Write-Host "验证文件：" -ForegroundColor Cyan
wsl -d Ubuntu-22.04 -- bash -c "ls -lh /mnt/d/swe-pruner-workspace/swe-pruner/swe-pruner/model/ | grep -E '(safetensors|json|txt)'"

Write-Host ""
Write-Host "💡 下一步：回复 '模型文件已完整下载'" -ForegroundColor Yellow
