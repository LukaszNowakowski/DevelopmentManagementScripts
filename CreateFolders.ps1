param (
	[String]$BranchDirectory = "C:\AzureDevOpsWorkspaces\Leonardo_Integration"
)

function createFolders 
{
	[CmdletBinding()]
	param(
		[string] $Mainpath,
		[string] $FolderToCreate
	)
	$path= $Mainpath+"${FolderToCreate}"
	if($FolderToCreate.tolower().startswith("docstore")) {
		Write-Output "creating root path: ${path}"
		New-Item -Path $path -ItemType directory -Force
	}
	elseif($FolderToCreate.tolower().startswith("batch")) {
		$FolderList=@('history\in','history\out','log','in','out','binary','err\in','err\out')
		Write-Output "creating root path: ${path}"
		Foreach ( $folder in $FolderList ) {
			if ( ! ( Test-Path "${path}\${folder}" ) ) {
				Write-Output "Batch folder: ${folder}" 
				New-Item -Path $path -Name ${folder} -ItemType directory -Force
			}
		}
	}
	else {
		Write-Output "There is a misconfiguration with [ ${FolderToCreate} ]"
	}
}

##################
############## MAIN START
##################


$Mainpath = "E:\NAS\"
$CsfLogPath = "E:\LOGS\CSF\Documents\AGDF"

if ( -not (Test-Path $Mainpath) )
{
	New-Item -Path $Mainpath -ItemType directory -Force
}

if ( -not (Test-Path $CsfLogPath) )
{
	New-Item -Path $CsfLogPath -ItemType Directory -Force
}

foreach ($line in (Get-Content "$BranchDirectory/BuildUtils/NasFolderList.txt"))
{
		createFolders $Mainpath $($line.trim())
}

