param (
	[String]$BranchDirectory = "C:\AzureDevOpsWorkspaces\Leonardo_Integration"
)

function StartProcessor {
	param (
		[String]$RunnerName,
		[String]$Executable
	)
	
	$Directory = "C:\Runners\$RunnerName"
	$app = "cmd"
	$parameters = @("/C"; "cd $Directory && $Executable")
	Start-Process $app $parameters
}

function CreateCopy{
	param (
		[String]$SourceDirectory,
		[String]$Name
	)
	
	New-Item "C:\Runners\$Name" -Type Directory
	Copy-Item "$SourceDirectory\*" "C:\Runners\$Name\"
}

function ChangeJobRunnerId{
	param (
		[String]$RunnerName,
		[String]$RunnerId
	)
	
	$config = [Xml](Get-Content "C:\Runners\$RunnerName\Sandpiper.JobEngine.SelfHosted.exe.config")
	$jobRunnerId = $config.configuration.appSettings.add | where { $_.key -eq "BatchPollingServiceConfiguration.JobRunnerId" }
	$jobRunnerId.value = $RunnerId
	$config.Save("C:\Runners\$RunnerName\Sandpiper.JobEngine.SelfHosted.exe.config")
}

Write-Host "Clearing runners"
Remove-Item "C:\Runners\*" -Recurse

Write-Host "Preparing and running document generation"
CreateCopy "$BranchDirectory\Sandpiper.DocumentGeneration\Sandpiper.DocumentGeneration.SelfHosted\bin\Debug" "DocumentGeneration"
StartProcessor "DocumentGeneration" "Sandpiper.DocumentGeneration.SelfHosted.exe"

Write-Host "Preparing and running JobEngine1"
CreateCopy "$BranchDirectory\Sandpiper.JobEngine\Sandpiper.JobEngine.SelfHosted\bin\Debug" "JobEngine1"
ChangeJobRunnerId "JobEngine1" "1"
StartProcessor "JobEngine1" "Sandpiper.JobEngine.SelfHosted.exe"

Write-Host "Preparing and running JobEngine2"
CreateCopy "$BranchDirectory\Sandpiper.JobEngine\Sandpiper.JobEngine.SelfHosted\bin\Debug" "JobEngine2"
ChangeJobRunnerId "JobEngine2" "2"
StartProcessor "JobEngine2" "Sandpiper.JobEngine.SelfHosted.exe"

Write-Host "Preparing and running JobEngine3"
CreateCopy "$BranchDirectory\Sandpiper.JobEngine\Sandpiper.JobEngine.SelfHosted\bin\Debug" "JobEngine3"
ChangeJobRunnerId "JobEngine3" "3"
StartProcessor "JobEngine3" "Sandpiper.JobEngine.SelfHosted.exe"

Write-Host "Preparing and running JobEngine4"
CreateCopy "$BranchDirectory\Sandpiper.JobEngine\Sandpiper.JobEngine.SelfHosted\bin\Debug" "JobEngine4"
ChangeJobRunnerId "JobEngine4" "4"
StartProcessor "JobEngine4" "Sandpiper.JobEngine.SelfHosted.exe"

Write-Host "Preparing and running SyncJobEngine"
CreateCopy "$BranchDirectory\Sandpiper.JobEngine\Sandpiper.SyncJobEngine.SelfHosted\bin\Debug" "SyncJobEngine"
StartProcessor "SyncJobEngine" "Sandpiper.SyncJobEngine.SelfHosted.exe"
