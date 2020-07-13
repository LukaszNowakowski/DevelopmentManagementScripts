param (
	[String]$BranchDirectory = "C:\AzureDevOpsWorkspaces\Leonardo_Integration",
	[switch]$NoDriveAttach,
	[switch]$NoGetLatest,
	[switch]$NoDatabaseDeploy,
	[switch]$NoVisualStudio,
	[switch]$NoApplications
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

If (!$NoApplications) {
	Write-Host "Publishing applications"
	./GetLatestApplicationsVersions.ps1
	./BuildApplications.ps1
	./DeployApplicationsDatabases.ps1
}

If (!$NoVisualStudio) {
	Write-Host "Starting Visual Studio"
	./OpenVisualStudio.ps1 $BranchDirectory
}

./CreateFolders.ps1