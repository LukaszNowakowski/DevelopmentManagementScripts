param (
	[String]$BranchDirectory = "C:\AzureDevOpsWorkspaces\Leonardo_Integration"
)

$TFPath = Get-ChildItem -Path "${Env:ProgramFiles(x86)}\Microsoft Visual Studio\2019" -Recurse -Filter "tf.exe" -ErrorAction SilentlyContinue | 
    Select-Object -ExpandProperty Versioninfo | Sort-Object -Property FileVersion -Descending | 
    Select-Object -First 1 | 
    ForEach-Object {$_.FileName}
$TFGetArgs = @("get", "/overwrite")

function GetLatestVersion
{
	param (
		$directory
	)

	$Current = Get-Location
	Set-Location $directory
	& $TFPath $TFGetArgs
	Set-Location $Current
}

GetLatestVersion "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_CommercialOffers"
GetLatestVersion "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_Documents"
GetLatestVersion "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_InsuranceCompanies"
GetLatestVersion "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_ReferentialData"
GetLatestVersion "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_SecurityAudit"
GetLatestVersion "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_SwaggerUI"
