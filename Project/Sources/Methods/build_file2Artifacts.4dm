//%attributes = {}
#DECLARE($file : Text)

var $fileObj : Object
var $path : Text


build_checkForArtifactsFolder

$fileObj:=File:C1566($file; fk platform path:K87:2)

$path:=System folder:C487(Documents folder:K41:18)+"artifacts"+Folder separator:K24:12+$fileObj.fullName

COPY DOCUMENT:C541($file; $path)
