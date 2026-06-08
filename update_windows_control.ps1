Install-Module -Name PSWindowsUpdate -Force -AllowClobber
Import-Module -Name PSWindowsUpdate
Get-WindowsUpdate
Install-WindowsUpdate -AcceptAll -AutoReboot
