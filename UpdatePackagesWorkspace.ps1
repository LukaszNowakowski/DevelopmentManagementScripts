$collection = "https://dev.azure.com/adf-darwin"
$workspaceName = "Agdf_Packages"

function GetPaths
{
	tf dir /folders $/Packages/*Main /recursive /collection:$collection
}

Remove-Item Mappings.txt
Remove-Item Mains.txt
tf workfold /workspace:$workspaceName >> Mappings.txt

GetPaths >> Mains.txt
