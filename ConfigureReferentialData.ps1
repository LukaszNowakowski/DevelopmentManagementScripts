#requires -RunAsAdministrator

Import-Module WebAdministration

function CreateWebApplication {
	param (
		[String]$WebsiteName,
		[String]$ApplicationName,
		[String]$Path,
		[String]$ApplicationPool
	)
	
	Write-Host (Join-Path (Join-Path "IIS:\Sites\" $WebsiteName) $ApplicationName)
	$application = New-Item (Join-Path (Join-Path "IIS:\Sites\" $WebsiteName) $ApplicationName) -physicalPath $Path -Type Application -Force
	Set-ItemProperty (Join-Path (Join-Path "IIS:\Sites\" $WebsiteName) $ApplicationName) -Name "applicationPool" -Value $ApplicationPool
	Write-Host "APP: $ApplicationName" -ForegroundColor "Yellow"
}

CreateWebApplication Leonardo_Integration Agdf.Api.ReferentialData C:\AzureDevOpsWorkspaces\Applications\Agdf\ReferentialData_Integration\Agdf.Api.ReferentialData axa