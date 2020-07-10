if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs -Wait; exit
}

Write-Host "Starting"
$path = "C:\AzureDevOpsWorkspaces\CSF.vhd"
Write-Host "Path created"
$script = "SELECT VDISK FILE=`"$path`"`r`nATTACH VDISK`r`nSELECT PARTITION 1`r`nASSIGN LETTER = E"
Write-Host "Script created"
$script | diskpart
Write-Host "Script ran"
