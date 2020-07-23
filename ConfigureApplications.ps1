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

CreateWebApplication Leonardo_Integration Agdf.Api.CommercialOffers C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_CommercialOffers\Agdf.Api.CommercialOffers axa
CreateWebApplication Leonardo_Integration Agdf.Api.Documents C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_Documents\Agdf.Api.Documents axa
CreateWebApplication Leonardo_Integration Agdf.Api.InsuranceCompanies C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_InsuranceCompanies\Agdf.Api.InsuranceCompanies axa
CreateWebApplication Leonardo_Integration Agdf.Api.ReferentialData C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_ReferentialData\Agdf.Api.ReferentialData axa
CreateWebApplication Leonardo_Integration Agdf.Api.SecurityAudit C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_SecurityAudit\Agdf.Api.SecurityAudit axa
CreateWebApplication Leonardo_Integration Agdf.Swagger C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_SwaggerUI\Agdf.Swagger axa
CreateWebApplication Leonardo_Integration Agdf.Api.Configuration C:\GitHub\Agdf.Configuration\Agdf.Api.Configuration axa
