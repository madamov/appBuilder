//%attributes = {}
#DECLARE->$paramsJSON : Text

var $path : Text
var $database; $buildFolder : Object

$paramsJSON:=""  // do not return Null 

$database:=Folder:C1567(fk database folder:K87:14)

$buildFolder:=Folder:C1567($database.platformPath+"buildFiles"; fk platform path:K87:2)

$path:=$buildFolder.platformPath+"parameters.json"

If (Test path name:C476($path)=Is a document:K24:1)
	$paramsJSON:=Document to text:C1236($path; "UTF-8")
End if 
