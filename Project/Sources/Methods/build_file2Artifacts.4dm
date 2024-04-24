//%attributes = {}
#DECLARE($file : Text)

var $fileObj : Object
var $path : Text


build_checkForArtifactsFolder

$fileObj:=File($file; fk platform path)

If ($fileObj.exists)
	
	$path:=System folder(Documents folder)+"artifacts"+Folder separator+$fileObj.fullName
	
	COPY DOCUMENT($file; $path)
	
End if 
