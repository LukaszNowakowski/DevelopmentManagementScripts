param (
	[String]$BranchDirectory = "C:\AzureDevOpsWorkspaces\Leonardo_Integration"
)

tf reconcile /clean /recursive $BranchDirectory