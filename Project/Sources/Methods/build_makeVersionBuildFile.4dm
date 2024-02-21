//%attributes = {}
// creates version and build JSON file from parameters.json file

var $parameters; $versions : Object
var $json; $path : Text

logLineInLogEvent("Getting parameters")

$parameters:=build_getCurrentParameters

logLineInLogEvent("Parameters fetched")

$versions:=New object:C1471

// $versions.buildNumber:=$parameters.build+1  // increase by one, that will be build number if build is successful
$versions.buildNumber:=$parameters.build  // increase by one, that will be build number if build is successful
$versions.version:=$parameters.version

$json:=JSON Stringify:C1217($versions; *)

logLineInLogEvent("Version and build numbers are "+$json)

build_dumpVar2File($json; "version.json")

$path:=Get 4D folder:C485(Current resources folder:K5:16)+"version.json"

TEXT TO DOCUMENT:C1237($path; $json; "UTF-8")

logLineInLogEvent("version.json file created in Resources folder")
