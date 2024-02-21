//%attributes = {}
var $path; $script; $cmd : Text

$path:=build_getScriptsPath

If (Is macOS:C1572)
	$script:="postBuild.sh"
	$cmd:=Convert path system to POSIX:C1106($path)+$script
Else 
	
	If (Is Windows:C1573)
		$script:="postBuild.bat"
		$cmd:=$path+$script
	Else 
		
		// Linux will go here
		
	End if 
End if 

logLineInLogEvent("Running: "+$cmd)

SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "false")
LAUNCH EXTERNAL PROCESS:C811($cmd)

logLineInLogEvent("Launched: "+$cmd)
