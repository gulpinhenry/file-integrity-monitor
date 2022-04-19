Write-Host ""
Write-Host "What would you like to do?"
Write-Host "A) Collect new Baseline?"
Write-Host "B) Begin monitoring files with saved baseline"

$response = Read-Host -Prompt "Please enter 'A' or 'B'"
# Future: add error checking
# Write-Host "User entered $($response)"

Function Calculate-File-Hash($filepath) { 
    $filehash = Get-FileHash -Path $filepath -Algorithm SHA512
    return $filehash
}

Function Erase-Baseline-If-Already-Exists(){
    $baselineExists = Test-Path -Path .\baseline.txt
    if ($baselineExists) {
        Remove-Item -Path .\baseline.txt
    }

}
if ($response -eq "A".ToUpper()) {
    # Calculate Hash from the target files and store in baseline.txt
    Write-Host "Calculate Hashes, make new baseline.txt" -ForegroundColor Cyan
    # Collect all files in the target folder
    $files = Get-ChildItem -Path .\Files
    # For each file, calculate the hash, and write to baseline.txt
    foreach ($f in $files){
        Calculate-File-Hash $f.FullName
        "$($hash.Path)|$($hash.Hash)" | Out-File -FilePath .\baseline.txt -Append
    }
}
elseif ($response -eq "B".ToUpper()) {
    # Begin monitoring files with saved Baseline
    Write-Host "Read existing baseline.txt, start monitoring files." -ForegroundColor Yellow
}