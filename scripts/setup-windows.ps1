# LifeOS one-shot setup for Windows 10/11.
# Run in PowerShell or Terminal (not as admin):
#   irm https://raw.githubusercontent.com/mitakihari/lifeos/main/scripts/setup-windows.ps1 | iex
# Safe to re-run: installed apps are skipped, existing clones are updated.

$ErrorActionPreference = "Stop"
$Owner   = "mitakihari"
$Root    = Join-Path $env:USERPROFILE "LifeOS"
$Toolkit = Join-Path $Root "lifeos"
$Vault   = Join-Path $Root "lifeos-vault"

function Step($msg) { Write-Host "`n==> $msg" -ForegroundColor Cyan }
function Refresh-Path {
    $env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
                [Environment]::GetEnvironmentVariable("Path", "User")
}
function Install-App($id, $name, $extra = @()) {
    $found = winget list --id $id -e --accept-source-agreements 2>$null | Select-String $id
    if ($found) { Write-Host "  $name already installed"; return }
    Write-Host "  installing $name..."
    winget install --id $id -e --silent --accept-package-agreements --accept-source-agreements @extra
    if ($LASTEXITCODE -ne 0) { throw "winget could not install $name (exit $LASTEXITCODE)" }
}

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    throw "winget isn't available. Install 'App Installer' from the Microsoft Store, then run this again."
}

Step "1/6 Installing apps (Git, Python, GitHub Desktop, Obsidian). Approve any Windows prompts."
Install-App "Git.Git" "Git"
Install-App "Python.Python.3.12" "Python 3.12" @("--override", "/quiet InstallAllUsers=0 PrependPath=1 Include_launcher=1")
Install-App "GitHub.GitHubDesktop" "GitHub Desktop"
Install-App "Obsidian.Obsidian" "Obsidian"
Refresh-Path

$py = $null
foreach ($cand in @("py -3.12", "py -3", "python")) {
    $parts = $cand.Split(" ")
    try {
        & $parts[0] @($parts[1..9] | Where-Object { $_ }) -c "import sys; sys.exit(sys.version_info < (3, 11))" 2>$null
        if ($LASTEXITCODE -eq 0) { $py = $parts; break }
    } catch {}
}
if (-not $py) { throw "Python 3.11+ still not found. Close this window, open a new Terminal, and run the command again." }
function Py { & $py[0] @($py[1..9] | Where-Object { $_ }) @args; if ($LASTEXITCODE -ne 0) { throw "python $args failed" } }

Step "2/6 Git identity"
if (-not (git config --global user.name))  { git config --global user.name "Fox Barnett" }
if (-not (git config --global user.email)) { git config --global user.email "$Owner@users.noreply.github.com" }
git config --global core.autocrlf false
Write-Host "  $(git config --global user.name) <$(git config --global user.email)>"

Step "3/6 Downloading your repos into $Root"
Write-Host "  If a GitHub sign-in window pops up, sign in as $Owner. That's how Git reaches your private vault."
New-Item -ItemType Directory -Force -Path $Root | Out-Null
foreach ($pair in @(@("lifeos", $Toolkit), @("lifeos-vault", $Vault))) {
    $name, $dir = $pair
    if (Test-Path (Join-Path $dir ".git")) {
        Write-Host "  $name exists, pulling updates"; git -C $dir pull --ff-only
    } else {
        git clone "https://github.com/$Owner/$name.git" $dir
        if ($LASTEXITCODE -ne 0) { throw "could not clone $name" }
    }
}

Step "4/6 Installing Python packages (Beancount, Fava, openpyxl)"
Py -m pip install --user --upgrade --quiet pip
Py -m pip install --user --quiet -r (Join-Path $Toolkit "requirements.txt")

Step "5/6 Wiring up the vault (Claude commands, secret-scan hook, Obsidian plugins)"
Py (Join-Path $Toolkit "scripts\lifeos.py") sync --vault $Vault
Py (Join-Path $Vault "_system\bin\lifeos.py") plugins install --vault $Vault

Step "6/6 Health check"
Py (Join-Path $Vault "_system\bin\lifeos.py") doctor --vault $Vault

Write-Host "`nDone. Your vault is at: $Vault" -ForegroundColor Green
Write-Host "Next: open Obsidian -> 'Open folder as vault' -> pick that folder." -ForegroundColor Green
