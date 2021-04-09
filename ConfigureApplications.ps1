#requires -RunAsAdministrator
param (
	[String]$WebSite = "Leonardo_Integration"
)

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

CreateWebApplication $WebSite Agdf.Api.CommercialOffers C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_CommercialOffers\Agdf.Api.CommercialOffers axa
CreateWebApplication $WebSite Agdf.Api.Documents C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_Documents\Agdf.Api.Documents axa
CreateWebApplication $WebSite Agdf.Api.InsuranceCompanies C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_InsuranceCompanies\Agdf.Api.InsuranceCompanies axa
CreateWebApplication $WebSite Agdf.Api.ReferentialData C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_ReferentialData\Agdf.Api.ReferentialData axa
CreateWebApplication $WebSite Agdf.Api.SecurityAudit C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_SecurityAudit\Agdf.Api.SecurityAudit axa
CreateWebApplication $WebSite Agdf.Swagger C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_SwaggerUI\Agdf.Swagger axa
CreateWebApplication $WebSite Agdf.Api.Configuration C:\AzureDevOpsWorkspaces\Git\Agdf.Api.Configuration\Agdf.Api.Configuration axa
CreateWebApplication $WebSite Agdf.Api.Logging C:\AzureDevOpsWorkspaces\Git\Agdf.Api.Logging\Agdf.Api.Logging axa
