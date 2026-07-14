$processName = "RedXGameLibrary"
if (Get-Process -Name $processName -ErrorAction SilentlyContinue) {
    Stop-Process -Name $processName -Force -ErrorAction SilentlyContinue
}

$steamProcess = "steam"
if (Get-Process -Name $steamProcess -ErrorAction SilentlyContinue) {
    Stop-Process -Name $steamProcess -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 3
}

$registryPath = "HKCU:\Software\Valve\Steam"
if (Test-Path $registryPath) {
    $steamRegistry = Get-ItemProperty -Path $registryPath
    $steamPath = $steamRegistry.SteamPath
    $steamExe = $steamRegistry.SteamExe

    if (-not $steamPath) {
        Exit
    }
    
    $steamPath = $steamPath -replace '/', '\'
    $targets = @("xinput1_4.dll", "version.dll", "appcache", "package")

    foreach ($target in $targets) {
        $fullPath = Join-Path $steamPath $target
        if (Test-Path $fullPath) {
            Remove-Item -Path $fullPath -Recurse -Force -ErrorAction SilentlyContinue
        }
    }

    if ($steamExe -and (Test-Path $steamExe)) {
        Start-Process -FilePath $steamExe
    }
}
