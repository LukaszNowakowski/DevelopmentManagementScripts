param (
	$SolutionPath,
	$MsBuildPath
)

$host.UI.RawUI.WindowTitle = "Building $SolutionPath"
& $MsBuildPath $SolutionPath /t:Restore /p:Configuration=Debug /p:nugetInteractive=true
& $MsBuildPath $SolutionPath /t:Build /p:Configuration=Debug
