//%attributes = {}
#DECLARE($file : Text)

var $fileObj; $params : Object
var $path : Text


build_checkForArtifactsFolder

$params:=build_getCurrentParameters

$fileObj:=File:C1566($file; fk platform path:K87:2)

// $path:=System folder(Documents folder)+"artifacts"+Folder separator+$fileObj.fullName
// $path:=Storage.buildConfig.artifacts+$fileObj.fullName
$path:=System folder:C487(Documents folder:K41:18)+String:C10($params.build)+Folder separator:K24:12+$fileObj.fullName

logLineInLogEvent("Copying "+$file+" to "+$path)

If (Test path name:C476($path)#Is a document:K24:1)
	COPY DOCUMENT:C541($file; $path)
	logLineInLogEvent("Copied "+$file+" to "+$path)
Else 
	logLineInLogEvent($path+" exists")
End if 

