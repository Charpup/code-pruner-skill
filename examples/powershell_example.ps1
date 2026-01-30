# PowerShell Usage Examples for Code Pruner Skill

# Example 1: Basic API call
Write-Host "Example 1: Basic Code Pruning" -ForegroundColor Green

$code = @"
def authenticate_user(username, password):
    if verify_credentials(username, password):
        return create_session(username)
    return None

def create_session(username):
    session_id = generate_session_id()
    store_session(session_id, username)
    return session_id

def logout_user(session_id):
    delete_session(session_id)
"@

$body = @{
    code  = $code
    query = "focus on authentication"
} | ConvertTo-Json

$response = Invoke-WebRequest -Uri "http://localhost:8000/prune" `
    -Method POST `
    -Body $body `
    -ContentType "application/json"

$result = $response.Content | ConvertFrom-Json
Write-Host "Relevance Score: $($result.score * 100)%"
Write-Host "Pruned Code:`n$($result.pruned_code)"

# Example 2: Batch processing multiple files
Write-Host "`nExample 2: Batch Processing" -ForegroundColor Green

$files = @(
    "C:\path\to\auth.py",
    "C:\path\to\payment.py",
    "C:\path\to\database.py"
)

$query = "database operations"

foreach ($file in $files) {
    if (Test-Path $file) {
        $code = Get-Content $file -Raw
        $body = @{code = $code; query = $query } | ConvertTo-Json
        
        $response = Invoke-WebRequest -Uri "http://localhost:8000/prune" `
            -Method POST `
            -Body $body `
            -ContentType "application/json"
        
        $result = $response.Content | ConvertFrom-Json
        Write-Host "$file - Reduced by $([math]::Round((1 - $result.pruned_code.Length / $code.Length) * 100, 1))%"
    }
}

# Example 3: Custom threshold
Write-Host "`nExample 3: Custom Threshold" -ForegroundColor Green

$body = @{
    code      = $code
    query     = "authentication logic"
    threshold = 0.9  # More strict
} | ConvertTo-Json

$response = Invoke-WebRequest -Uri "http://localhost:8000/prune" `
    -Method POST `
    -Body $body `
    -ContentType "application/json"

$result = $response.Content | ConvertFrom-Json
Write-Host "High threshold result: $($result.score * 100)%"

# Example 4: Error handling
Write-Host "`nExample 4: Error Handling" -ForegroundColor Green

try {
    $response = Invoke-WebRequest -Uri "http://localhost:8000/prune" `
        -Method POST `
        -Body (@{code = "test"; query = "test" } | ConvertTo-Json) `
        -ContentType "application/json" `
        -TimeoutSec 5
    Write-Host "Service is running ✓"
}
catch {
    Write-Host "Service error: $_" -ForegroundColor Red
    Write-Host "Start service with: .\scripts\start-service.ps1"
}
