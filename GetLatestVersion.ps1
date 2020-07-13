param (
	[String]$BranchDirectory = "C:\AzureDevOpsWorkspaces\Leonardo_Integration"
)

$TFPath = Get-ChildItem -Path "${Env:ProgramFiles(x86)}\Microsoft Visual Studio\2019" -Recurse -Filter "tf.exe" -ErrorAction SilentlyContinue | 
    Select-Object -ExpandProperty Versioninfo | Sort-Object -Property FileVersion -Descending | 
    Select-Object -First 1 | 
    ForEach-Object {$_.FileName}
$TFGetArgs = @("get", "/overwrite")

$Current = Get-Location
Set-Location C:\AzureDevOpsWorkspaces\DocGenAssets_Integration
& $TFPath $TFGetArgs
Set-Location $BranchDirectory
& $TFPath $TFGetArgs
Set-Location $Current
