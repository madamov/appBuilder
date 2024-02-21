//%attributes = {}
// perform simulation of headless build process for debugging

var $params; $status; $buildStatus : Object
var $inHeadless : Boolean
var $myParams : Text

// $params:=build_getCurrentParameters

$inHeadless:=Get application info:C1599.headless

$myParams:=build_getCurrentJSONParameters

runHeadless($myParams)

//If (Not($inHeadless))
//// get licenses from local repo

//// $params.pathToLicenses:=Convert path system to POSIX(build_getLocalRepoLicensesPath)
//If (Is macOS)
//$params.pathToVL:=Convert path system to POSIX("Macintosh HD:Applications:4D v19 R8:4D Volume Desktop.app:")
//// $params.pathToLicenses:=Convert path system to POSIX("/Volumes/Radni/madamov/Documents/4D/Projects/4d_dev_licenses/v19")
//$params.pathToLicenses:="/Volumes/Radni/madamov/Documents/4D/Projects/4d_dev_licenses/v19"
//$params.action:=$params.actionMac
//Else 
//If (Is Windows)
//$params.pathToVL:=System folder(Documents folder)+"4D Volume Desktop\\"
//End if 
//End if 
//End if 

//build_logPlatformInfo

//logLineInLogEvent("Compiling ...")

//$status:=build_CompileOnly

//If ($status.success)

//logLineInLogEvent("Building ...")

//$buildStatus:=build_all($params)

//If ($buildStatus.success)
//logLineInLogEvent("Building done OK...")
//End if 

//End if 


