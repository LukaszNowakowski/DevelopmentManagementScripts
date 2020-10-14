function DeployDatabase
{
	param (
		$databaseDeployScript
	)

    start powershell $databaseDeployScript
}

DeployDatabase "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_CommercialOffers\BuildUtils\database_deploy.ps1"
DeployDatabase "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_Documents\BuildUtils\database_deploy.ps1"
DeployDatabase "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_InsuranceCompanies\BuildUtils\database_deploy.ps1"
DeployDatabase "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_SecurityAudit\BuildUtils\database_deploy.ps1"
