param (
	[String]$BranchDirectory = "C:\AzureDevOpsWorkspaces\Leonardo_Integration"
)

function cleanFolders 
{
	[CmdletBinding()]
	param(
		[string] $Mainpath,
		[string] $FolderToClean
	)
	$path= $Mainpath+"${FolderToClean}"
	if($FolderToClean.tolower().startswith("docstore")) {
		Write-Output "cleaning root path: ${path}"
		Remove-Item $path\* -recurse -force
	}
	elseif($FolderToClean.tolower().startswith("batch")) {
		$FolderList=@('history\in','history\out','log','in','out','binary','err\in','err\out')
		Write-Output "cleaning root path: ${path}"
		Foreach ( $folder in $FolderList ) {
			if (( Test-Path "${path}\${folder}" ) ) {
				Write-Output "cleaning batch folder: ${path}\${folder}" 
				Remove-Item $path\${folder}\* -recurse -force
			}
		}
	}
	else {
		Write-Output "There is a misconfiguration with [ ${FolderToCreate} ]"
	}
}

function Run
{
	param (
		[string]$mainPath,
		[string]$csfLogPath
	)
	if ( -not (Test-Path $Mainpath) )
	{
		Throw "The path ${Mainpath} doesn't exist. Please check that you use the correct DarwinProduct name."
	}

	if (Test-Path $CsfLogPath)
	{
		Remove-Item $CsfLogPath\* -recurse -force
	}

	foreach ($line in (Get-Content "$BranchDirectory/BuildUtils/NasFolderList.txt"))
	{
			cleanFolders $Mainpath $($line.trim())
	}
}

Run "E:\NAS\" "E:\LOGS\CSF\Documents\AGDF"
