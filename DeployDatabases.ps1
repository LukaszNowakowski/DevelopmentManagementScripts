param (
	[String]$BranchDirectory = "C:\AzureDevOpsWorkspaces\Leonardo_Integration"
)

start powershell "$BranchDirectory\BuildUtils\database_deploy_all.ps1"
