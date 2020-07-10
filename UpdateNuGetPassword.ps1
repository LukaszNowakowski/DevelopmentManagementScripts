param (
	[Parameter(Mandatory=$true)]
	[String]$password
)

function Update
{
	param (
		$password,
		$directory
	)

	Set-Location $directory

	nuget sources update -Name "AxaNugetDarwinPackages" -UserName "ADMGLOBALDIRECT\l.nowakowski" -Password $password
}

$Current = Get-Location

Update $password C:\AzureDevOpsWorkspaces\Leonardo_Integration
Update $password C:\AzureDevOpsWorkspaces\Packages
Update $password C:\AzureDevOpsWorkspaces\Applications

Set-Location $Current