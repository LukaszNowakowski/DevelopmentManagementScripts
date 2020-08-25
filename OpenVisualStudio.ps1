param (
	[String]$BranchDirectory = "C:\AzureDevOpsWorkspaces\Leonardo_Integration"
)

Start-Process "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\IDE\devenv.exe"
Start-Process "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\IDE\devenv.exe" "$BranchDirectory\Darwin.sln" -Verb RunAs
Start-Process "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\IDE\devenv.exe" "$BranchDirectory\Db\Databases.sln"
