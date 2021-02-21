$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
if (!$?) {
    Write-Error "Please run with adminstrator rights. Enable developer mode too."
    Exit 1
}

Write-Debug "Installing Scoop..."
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

$PACKAGES = (Get-Content "$scriptPath/Scoopfile") -join ' '
scoop install $PACKAGES

Write-Debug "Applying Windows Terminal Configuration..."
Copy-Item "$scriptPath\manual\windows-terminal.json" "$env:LOCALAPPDATA\Microsoft\Windows Terminal\settings.json"

Write-Debug "Installing MSYS2..."
(New-Object System.Net.WebClient).DownloadFile('https://repo.msys2.org/distrib/x86_64/msys2-x86_64-20210105.exe', "$env:TEMP\msys2-install.exe")
cmd.exe -c "$env:TEMP\msys2-install.exe --accept-licenses --default-answer --confirm-command"

$env:MSYS2_PATH_TYPE='inherit'
$env:MSYSTEM='mingw64'
C:\msys64\usr\bin\bash -lc "''"
C:\msys64\usr\bin\bash -lc "'pacman --noconfirm -Syuu'"  # Core update (in case any core packages are outdated)
C:\msys64\usr\bin\bash -lc "'pacman --noconfirm -Syuu'"  # Normal update
C:\msys64\usr\bin\bash -l  "$scriptPath\setup.sh"        # Run setup on MSYS2