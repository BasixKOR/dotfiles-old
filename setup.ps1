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