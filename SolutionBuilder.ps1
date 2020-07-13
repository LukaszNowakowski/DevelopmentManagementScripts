param (
	$SolutionPath,
	$MsBuildPath
)

$host.UI.RawUI.WindowTitle = "Building $SolutionPath"
& $MsBuildPath $SolutionPath /t:Restore /p:Configuration=Debug
& $MsBuildPath $SolutionPath /t:Build /p:Configuration=Debug
