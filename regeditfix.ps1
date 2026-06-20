# ============================================================
#  SteamFix.ps1  –  Steam Temizlik & Yeniden Kurulum Scripti
# ============================================================
# irm <url> | iex   VEYA   .\SteamFix.ps1  ile çalışır.
# Her iki durumda da yönetici PowerShell gereklidir.

#region -- Yönetici Yükseltme --
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    # Dosya olarak çalıştırılıyorsa (PSCommandPath dolu) → dosyayı yönetici olarak yeniden başlat
    if ($PSCommandPath) {
        Write-Host "Yönetici ayrıcalığı gerekiyor, yeniden başlatılıyor..." -ForegroundColor Yellow
        Start-Process -FilePath "powershell.exe" `
            -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" `
            -Verb RunAs -Wait
        exit
    } else {
        # irm | iex ile çalıştırılıyor → scripti encoded olarak yeniden başlat
        Write-Host "Yönetici ayrıcalığı gerekiyor, yeniden başlatılıyor (irm modu)..." -ForegroundColor Yellow
        $scriptContent = (Invoke-RestMethod -Uri "https://redxhub.com/raw/regeditfix.ps1" -UseBasicParsing)
        $encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($scriptContent))
        Start-Process -FilePath "powershell.exe" `
            -ArgumentList "-NoProfile -ExecutionPolicy Bypass -EncodedCommand $encoded" `
            -Verb RunAs -Wait
        exit
    }
}
#endregion

$ErrorActionPreference = "Stop"

# ─────────────────────────────────────────────────────────────
# ADIM 1 – Steam'i Kapat
# ─────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkCyan
Write-Host " ADIM 1: Steam kapatılıyor..." -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkCyan

$steamProcesses = Get-Process -Name "steam" -ErrorAction SilentlyContinue
if ($steamProcesses) {
    Stop-Process -Name "steam" -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 3
    Write-Host "Steam başarıyla kapatıldı." -ForegroundColor Green
} else {
    Write-Host "Steam zaten çalışmıyor." -ForegroundColor Yellow
}

# ─────────────────────────────────────────────────────────────
# ADIM 2 – Steam Klasöründen DLL Dosyalarını Sil
# ─────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkCyan
Write-Host " ADIM 2: DLL dosyaları siliniyor..." -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkCyan

# Steam kurulum klasörünü kayıt defterinden bul
$steamInstallPath = $null
$regPaths = @(
    "HKLM:\SOFTWARE\Valve\Steam",
    "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam",
    "HKCU:\SOFTWARE\Valve\Steam"
)
foreach ($rp in $regPaths) {
    if (Test-Path $rp) {
        $val = (Get-ItemProperty -Path $rp -Name "InstallPath" -ErrorAction SilentlyContinue).InstallPath
        if ($val -and (Test-Path $val)) {
            $steamInstallPath = $val
            break
        }
    }
}

if (-not $steamInstallPath) {
    # Kayıt defterinde bulunamazsa yaygın konumları dene
    $commonPaths = @(
        "C:\Program Files (x86)\Steam",
        "C:\Program Files\Steam",
        "D:\Steam",
        "E:\Steam"
    )
    foreach ($cp in $commonPaths) {
        if (Test-Path "$cp\steam.exe") {
            $steamInstallPath = $cp
            break
        }
    }
}

if ($steamInstallPath) {
    Write-Host "Steam klasörü bulundu: $steamInstallPath" -ForegroundColor Gray
    $dllFiles = @("dwmapi.dll", "xinput1_4.dll")
    foreach ($dll in $dllFiles) {
        $dllPath = Join-Path $steamInstallPath $dll
        if (Test-Path $dllPath) {
            Remove-Item -Path $dllPath -Force
            Write-Host "Silindi : $dllPath" -ForegroundColor Green
        } else {
            Write-Host "Bulunamadı (atlandı): $dllPath" -ForegroundColor Yellow
        }
    }
    
    $packageInfoPath = Join-Path $steamInstallPath "appcache\packageinfo.vdf"
    if (Test-Path $packageInfoPath) {
        Remove-Item -Path $packageInfoPath -Force
        Write-Host "Silindi : $packageInfoPath" -ForegroundColor Green
    } else {
        Write-Host "Bulunamadı (atlandı): $packageInfoPath" -ForegroundColor Yellow
    }
} else {
    Write-Host "UYARI: Steam kurulum klasörü bulunamadı. DLL silme adımı atlandı." -ForegroundColor Red
}

# ─────────────────────────────────────────────────────────────
# ADIM 3 – Steamtools Kayıt Defteri Anahtarını Sil
# ─────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkCyan
Write-Host " ADIM 3: Steamtools kayıt defteri anahtarı siliniyor..." -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkCyan

$regKeyPath      = "Software\Valve\Steamtools"
$fullRegistryPath = "HKCU:\Software\Valve\Steamtools"
$currentUser     = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

Write-Host "3a. 'İzin Verme' kilidi kaldırılıyor..." -ForegroundColor Cyan

$registryKey = $null
try {
    $registryKey = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey(
        $regKeyPath,
        [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,
        [System.Security.AccessControl.RegistryRights]::ChangePermissions
    )
} catch { }

if ($registryKey -ne $null) {
    $acl = $registryKey.GetAccessControl()

    $denyRules = $acl.GetAccessRules($true, $false, [System.Security.Principal.NTAccount]) |
        Where-Object { $_.IdentityReference -eq $currentUser -and $_.AccessControlType -eq "Deny" }

    foreach ($rule in $denyRules) {
        $acl.RemoveAccessRuleSpecific($rule)
    }

    $allowRule = New-Object System.Security.AccessControl.RegistryAccessRule(
        $currentUser,
        "FullControl",
        "ContainerInherit,ObjectInherit",
        "None",
        "Allow"
    )
    $acl.ResetAccessRule($allowRule)

    try {
        $registryKey.SetAccessControl($acl)
        $registryKey.Close()
        Write-Host "Kilit başarıyla kaldırıldı." -ForegroundColor Green

        Write-Host "3b. Steamtools anahtarı siliniyor..." -ForegroundColor Cyan
        if (Test-Path $fullRegistryPath) {
            Remove-Item -Path $fullRegistryPath -Recurse -Force
            Write-Host "BAŞARILI: Steamtools anahtarı ve tüm içeriği silindi!" -ForegroundColor Green
        } else {
            Write-Host "Anahtar zaten mevcut değil." -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Hata (SetAccessControl): $_" -ForegroundColor Red
        if ($registryKey -ne $null) { $registryKey.Close() }
    }
} else {
    Write-Host "Anahtar doğrudan açılamadı, doğrudan silme deneniyor..." -ForegroundColor Yellow
    if (Test-Path $fullRegistryPath) {
        try {
            Remove-Item -Path $fullRegistryPath -Recurse -Force
            Write-Host "BAŞARILI: Steamtools anahtarı doğrudan silindi!" -ForegroundColor Green
        } catch {
            Write-Host "Hata: Anahtar silinemedi. Regedit açıksa kapatıp tekrar deneyin." -ForegroundColor Red
        }
    } else {
        Write-Host "Belirtilen kayıt defteri yolu zaten bulunamadı." -ForegroundColor Yellow
    }
}

# ─────────────────────────────────────────────────────────────
# ADIM 4 – redxhub.com fix.ps1 Çalıştır
# ─────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkCyan
Write-Host " ADIM 4: RedX fix scripti çalıştırılıyor..." -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkCyan

try {
    Invoke-Expression (Invoke-RestMethod -Uri "https://redxhub.com/raw/fix.ps1" -UseBasicParsing)
    Write-Host "ADIM 4 tamamlandı." -ForegroundColor Green
} catch {
    Write-Host "Hata (ADIM 4): $_" -ForegroundColor Red
}

# ─────────────────────────────────────────────────────────────
# ADIM 5 – GitHub fix.ps1 Çalıştır
# ─────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkCyan
Write-Host " ADIM 5: GitHub fix scripti çalıştırılıyor..." -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkCyan

try {
    Invoke-Expression (Invoke-RestMethod -Uri "https://raw.githubusercontent.com/Scriptez1/RedXFreeSteamInstaller/refs/heads/main/fix.ps1" -UseBasicParsing)
    Write-Host "ADIM 5 tamamlandı." -ForegroundColor Green
} catch {
    Write-Host "Hata (ADIM 5): $_" -ForegroundColor Red
}

# ─────────────────────────────────────────────────────────────
# ADIM 6 – Steam'i Aç (Açık değilse)
# ─────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkCyan
Write-Host " ADIM 6: Steam açılıyor / bekleniyor..." -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkCyan

# Steam'in kendiliğinden açılması için 15 saniye bekle
Write-Host "Steam'in açılması için 15 saniye bekleniyor..." -ForegroundColor Gray
Start-Sleep -Seconds 15

$steamRunning = Get-Process -Name "steam" -ErrorAction SilentlyContinue
if ($steamRunning) {
    Write-Host "Steam zaten çalışıyor." -ForegroundColor Green
} else {
    Write-Host "Steam çalışmıyor, başlatılıyor..." -ForegroundColor Yellow
    if ($steamInstallPath -and (Test-Path "$steamInstallPath\steam.exe")) {
        Start-Process -FilePath "$steamInstallPath\steam.exe"
        Write-Host "Steam başlatıldı: $steamInstallPath\steam.exe" -ForegroundColor Green
    } else {
        # Protokol üzerinden dene
        try {
            Start-Process "steam://"
            Write-Host "Steam protokolü üzerinden başlatıldı." -ForegroundColor Green
        } catch {
            Write-Host "UYARI: Steam otomatik başlatılamadı. Lütfen manuel olarak açın." -ForegroundColor Red
        }
    }
}

# ─────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkCyan
Write-Host " TÜM İŞLEMLER TAMAMLANDI!" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkCyan
Write-Host ""
Write-Host "Devam etmek için bir tuşa basın..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
