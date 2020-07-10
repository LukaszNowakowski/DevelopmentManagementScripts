param (
	[String]$BranchDirectory = "C:\AzureDevOpsWorkspaces\Leonardo_Integration"
)

function StartProcessor {
	param (
		[String]$Directory,
		[String]$Application
	)
	
	$app = "cmd"
	$parameters = @("/C"; "cd $Directory && $Application")
	Start-Process $app $parameters
}

Clear-Host

StartProcessor "$BranchDirectory\Sandpiper.DocumentGeneration\Sandpiper.DocumentGeneration.SelfHosted\bin\Debug" "Sandpiper.DocumentGeneration.SelfHosted.exe"
StartProcessor "$BranchDirectory\Sandpiper.JobEngine\Sandpiper.JobEngine.SelfHosted\bin\Debug" "Sandpiper.JobEngine.SelfHosted.exe"
StartProcessor "$BranchDirectory\Sandpiper.JobEngine\Sandpiper.SyncJobEngine.SelfHosted\bin\Debug" "Sandpiper.SyncJobEngine.SelfHosted.exe"
