param (
	[String]$BranchDirectory = "C:\AzureDevOpsWorkspaces\Leonardo_Integration",
	[switch]$NoDriveAttach,
	[switch]$NoGetLatest,
	[switch]$NoDatabaseDeploy,
	[switch]$NoVisualStudio
)

If (!$NoDriveAttach) {
	Write-Host "Attaching drive"
	./AttachVirtualDrive.ps1
}

If (!$NoGetLatest) {
	Write-Host "Getting latest version"
	./GetLatestVersion.ps1 $BranchDirectory
}

If (!$NoDatabaseDeploy) {
	Write-Host "Deploying databases"
	./DeployDatabases.ps1 $BranchDirectory
}

If (!$NoVisualStudio) {
	Write-Host "Starting Visual Studio"
	./OpenVisualStudio.ps1 $BranchDirectory
}

./CreateFolders.ps1