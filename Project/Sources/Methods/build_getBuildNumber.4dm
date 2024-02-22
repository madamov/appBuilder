//%attributes = {}
#DECLARE()->$buildNumber : Text

var $buildFilesFolder : 4D.Folder
var $parametersFile : 4D.File
var $config : Object


$buildFilesFolder:=build_getBuildFilesFolder

$parametersFile:=$buildFilesFolder.file("parameters.json")

$config:=JSON Parse($parametersFile.getText())

$buildNumber:=String($config.build)
