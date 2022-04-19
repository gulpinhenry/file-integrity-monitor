Write-Host ""
Write-Host "What would you like to do?"
Write-Host ""
Write-Host "    A) Collect new Baseline?"
Write-Host "    B) Begin monitoring files with saved baseline"
Write-Host ""

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
    # Delete baseline.txt if it already exists
    Erase-Baseline-If-Already-Exists
    # Calculate Hash from the target files and store in baseline.txt
    # Write-Host "Calculate Hashes, make new baseline.txt" -ForegroundColor Cyan
    # Collect all files in the target folder
    $files = Get-ChildItem -Path .\Files
    # For each file, calculate the hash, and write to baseline.txt
    foreach ($f in $files){
        $hash = Calculate-File-Hash $f.FullName
        "$($hash.Path)|$($hash.Hash)" | Out-File -FilePath .\baseline.txt -Append
    }
}
elseif ($response -eq "B".ToUpper()) {
    $fileHashDictionary = @{}
    # Load file|hash from baseline.txt and store them in a dictionary
    $filePathesandHashes = Get-Content -Path .\baseline.txt

    foreach ($f in $filePathesandHashes) {
        $fileHashDictionary.add($f.Split("|")[0], $f.Split("|")[1])
    }

    # Begin (continuosly) monitoring files with saved Baseline
    while ($true) {
        Start-Sleep -Seconds 1
        Write-Host "Checking if files match..."
    }
    # Begin monitoring files with saved Baseline
    Write-Host "Read existing baseline.txt, start monitoring files." -ForegroundColor Yellow
}