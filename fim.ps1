Write-Host ""
Write-Host "What would you like to do?"
Write-Host "A) Collect new Baseline?"
Write-Host "B) Begin monitoring files with saved baseline"

$response = Read-Host -Prompt "Please enter 'A' or 'B'"
# Future: add error checking
# Write-Host "User entered $($response)"
