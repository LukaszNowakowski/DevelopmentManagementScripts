$vsPath = "${Env:ProgramFiles(x86)}\Microsoft Visual Studio*"
$msbuildFile = "MSBuild.exe"
$msbuild = Get-ChildItem -Path $vsPath -Recurse -Filter $msbuildFile -ErrorAction SilentlyContinue |
	Select-Object -ExpandProperty Versioninfo | Sort-Object -Property FileVersion -Descending | 
	Select-Object -First 1 | 
	ForEach-Object {$_.FileName}

function StartBuild
{
	param (
		$solutionPath,
		$msBuildPath
	)

	start powershell "./SolutionBuilder.ps1 $solutionPath '$msBuildPath'"
}

StartBuild "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_CommercialOffers\CommercialOffers.sln" $msbuild
StartBuild "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_Documents\Agdf.Documents.sln" $msbuild
StartBuild "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_InsuranceCompanies\InsuranceCompanies.sln" $msbuild
StartBuild "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_ReferentialData\ReferentialData.sln" $msbuild
StartBuild "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_SecurityAudit\SecurityAudit.sln" $msbuild
StartBuild "C:\AzureDevOpsWorkspaces\Applications\Integration\Agdf_SwaggerUI\Agdf.Swagger.sln" $msbuild
