$inputFile = "vendor_file_list.txt"
$outputFile = "proprietary-files.txt"

# Read lines (handling potential encoding issues by forcing string read)
$files = Get-Content $inputFile

# Start with header
$header = @"
#
# Copyright (C) 2024 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

"@
$header | Out-File $outputFile -Encoding UTF8

# Categories to match
$patterns = @(
    "vendor/lib64/lib.*\.so$",
    "vendor/lib/lib.*\.so$",
    "vendor/bin/.*",
    "vendor/firmware/.*",
    "vendor/app/.*\.apk",
    "vendor/priv-app/.*\.apk",
    "vendor/etc/.*\.rc",
    "vendor/etc/.*\.xml"
)

# Lists to hold grouped files
$audio = @()
$camera = @()
$sensors = @()
$display = @()
$media = @()
$connectivity = @()
$other = @()

foreach ($file in $files) {
    # Clean path (remove leading /)
    $cleanPath = $file -replace "^/vendor/", "vendor/"
    if ($cleanPath -eq $file) { $cleanPath = "vendor/" + $file -replace "^/", "" }
    
    # Check if file exists in patterns
    $match = $false
    foreach ($p in $patterns) {
        if ($cleanPath -match $p) { $match = $true; break }
    }

    if ($match) {
        # Grouping logic
        if ($cleanPath -match "audio") { $audio += $cleanPath }
        elseif ($cleanPath -match "camera" -or $cleanPath -match "isp") { $camera += $cleanPath }
        elseif ($cleanPath -match "sensor") { $sensors += $cleanPath }
        elseif ($cleanPath -match "graphics" -or $cleanPath -match "gralloc" -or $cleanPath -match "hwc" -or $cleanPath -match "display") { $display += $cleanPath }
        elseif ($cleanPath -match "media" -or $cleanPath -match "codec") { $media += $cleanPath }
        elseif ($cleanPath -match "wifi" -or $cleanPath -match "bluetooth" -or $cleanPath -match "bt" -or $cleanPath -match "gps" -or $cleanPath -match "gnss") { $connectivity += $cleanPath }
        else { $other += $cleanPath }
    }
}

# Helper function to write section
function Write-Section($title, $list) {
    if ($list.Count -gt 0) {
        "" | Out-File $outputFile -Append -Encoding UTF8
        "# $title" | Out-File $outputFile -Append -Encoding UTF8
        $list | Sort-Object | ForEach-Object { $_ | Out-File $outputFile -Append -Encoding UTF8 }
    }
}

Write-Section "Audio" $audio
Write-Section "Camera" $camera
Write-Section "Display & Graphics" $display
Write-Section "Sensors" $sensors
Write-Section "Media" $media
Write-Section "Connectivity (WiFi/BT/GNSS)" $connectivity
Write-Section "Other" $other

Write-Host "Generated proprietary-files.txt with $(($audio.Count + $camera.Count + $sensors.Count + $display.Count + $media.Count + $connectivity.Count + $other.Count)) files."
