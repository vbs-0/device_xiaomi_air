$inputFile = "proprietary-files.txt"
$startDir = "proprietary"

# Ensure output directory exists
if (!(Test-Path $startDir)) { New-Item -ItemType Directory -Force -Path $startDir }

# Read files
$lines = Get-Content $inputFile
$total = 0
foreach ($line in $lines) { if (![string]::IsNullOrWhiteSpace($line) -and !$line.StartsWith("#")) { $total++ } }

Write-Host "Starting robust extraction of $total files (with Root fallback)..."

$count = 0
foreach ($line in $lines) {
    if ([string]::IsNullOrWhiteSpace($line) -or $line.StartsWith("#")) { continue }

    $parts = $line -split ":"
    $src = $parts[0].Trim()
    if ($src.StartsWith("-")) { $src = $src.Substring(1) }
    if (!$src.StartsWith("/")) { $devicePath = "/$src" } else { $devicePath = $src }
    
    $localPath = Join-Path $startDir $src
    $localDir = Split-Path $localPath
    if (!(Test-Path $localDir)) { New-Item -ItemType Directory -Force -Path $localDir > $null }
    
    # Try direct pull first
    $err = $null
    $output = adb pull $devicePath $localPath 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        $count++
        Write-Progress -Activity "Extracting Vendor Blobs" -Status "$count / $total" -PercentComplete (($count / $total) * 100) -CurrentOperation "Direct Pull: $src"
    } else {
        # Failed, try Root Copy method
        # Write-Host "Direct pull failed, trying Root copy for: $src" -ForegroundColor Yellow
        
        adb shell "su -c 'cp $devicePath /sdcard/blob_tmp && chmod 777 /sdcard/blob_tmp'" 2>&1 | Out-Null
        $outputRoot = adb pull /sdcard/blob_tmp $localPath 2>&1
        
        if ($LASTEXITCODE -eq 0) {
             $count++
             Write-Progress -Activity "Extracting Vendor Blobs" -Status "$count / $total" -PercentComplete (($count / $total) * 100) -CurrentOperation "Root Pull: $src"
        } else {
             Write-Host "Failed to pull: $src" -ForegroundColor Red
        }
    }
}

# Cleanup
adb shell "rm /sdcard/blob_tmp" 2>&1 | Out-Null

Write-Host "Extraction complete. Extracted $count files."
