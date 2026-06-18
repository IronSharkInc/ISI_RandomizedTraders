# Copy and patch trader files script
# Usage: Run in PowerShell:
#   powershell -NoProfile -ExecutionPolicy Bypass -File "copy_and_patch_traders.ps1"

$src = 'D:\SteamLibrary\steamapps\common\7 Days To Die\Data\Prefabs\POIs'
$dst = 'D:\SteamLibrary\steamapps\common\7 Days To Die\Mods\ISI_RandomizedTraders\Prefabs\POIs'

# Names to copy from source and then duplicate to mapped names
$names = @('trader_rekt','trader_jen','trader_bob','trader_hugh','trader_joel')
$map = @{ 
    'trader_rekt' = 'a_pine_forest_trader';
    'trader_jen'  = 'a_burnt_forest_trader';
    'trader_bob'  = 'a_desert_trader';
    'trader_hugh' = 'a_snow_trader';
    'trader_joel' = 'a_wasteland_trader';
}

if (-not (Test-Path -LiteralPath $dst)) {
    New-Item -ItemType Directory -Path $dst -Force | Out-Null
}

# Remove existing files in destination to ensure a clean copy
Write-Output "Removing existing files in $dst"
try {
    Get-ChildItem -LiteralPath $dst -File -ErrorAction SilentlyContinue | ForEach-Object {
        Remove-Item -LiteralPath $_.FullName -Force -ErrorAction Stop
        Write-Output "Removed: $($_.Name)"
    }
} catch {
    Write-Warning "Failed to remove some files in $dst -- $_"
}

Write-Output 'Copying trader files from:'
Write-Output "  $src"
Write-Output 'to:'
Write-Output "  $dst"
Write-Output ''

foreach ($name in $names) {
    # match any files that start with the trader name (e.g. trader_hugh.xml, trader_hugh_signs.xml)
    $files = Get-ChildItem -LiteralPath $src -File -ErrorAction SilentlyContinue | Where-Object { $_.Name -like "$name*.*" }
    if ($files.Count -eq 0) {
        Write-Output "No files found for $name"
        continue
    }

    foreach ($f in $files) {
        Copy-Item -LiteralPath $f.FullName -Destination (Join-Path $dst $f.Name) -Force
        Write-Output "Copied: $($f.Name)"
    }

    # Patch ThemeTags only in the main prefab XML named exactly "$name.xml"
    $xmlFiles = Get-ChildItem -LiteralPath $dst -File | Where-Object { $_.Name -eq "$name.xml" }
    foreach ($xf in $xmlFiles) {
        try {
            [xml]$doc = Get-Content -LiteralPath $xf.FullName
            $nodes = $doc.SelectNodes("//property[@name='ThemeTags']")
            if ($nodes -and $nodes.Count -gt 0) {
                foreach ($n in $nodes) {
                    $attr = $n.Attributes['value']
                    if ($attr) {
                        $attr.Value = 'trader'
                    } else {
                        $newAttr = $doc.CreateAttribute('value')
                        $newAttr.Value = 'trader'
                        $n.Attributes.Append($newAttr) | Out-Null
                    }
                }
                $doc.Save($xf.FullName)
                Write-Output "Patched ThemeTags in $($xf.Name)"
            } else {
                Write-Output "No ThemeTags property found in $($xf.Name)"
            }
        } catch {
            Write-Warning "Failed to parse/patch XML DOM: $($xf.FullName) -- $_"
        }
    }
}

Write-Output ''
Write-Output 'Duplicating to mapped names...'
foreach ($old in $names) {
    $new = $map[$old]
    if (-not $new) {
        Write-Warning "No mapping for $old"
        continue
    }

    # include any files that start with the old name so signs and other variants are duplicated
    $copiedFiles = Get-ChildItem -LiteralPath $dst -File | Where-Object { $_.Name -like "$old*.*" }
    foreach ($f in $copiedFiles) {
        $newName = $f.Name -replace [regex]::Escape($old), $new
        Copy-Item -LiteralPath $f.FullName -Destination (Join-Path $dst $newName) -Force
        Write-Output "Created: $newName"
    }
}

Write-Output ''
Write-Output 'Done. Please verify files in:'
Write-Output "  $dst"
