//%attributes = {}
// gets parameters from buildFiles folder

#DECLARE->$parameters : Object

var $path; $json : Text
var $database; $buildFolder : Object

$database:=Folder:C1567(fk database folder:K87:14)

$buildFolder:=Folder:C1567($database.platformPath+"buildFiles"; fk platform path:K87:2)

$path:=$buildFolder.platformPath+"parameters.json"

If (Test path name:C476($path)=Is a document:K24:1)
	$json:=Document to text:C1236($path; "UTF-8")
	$parameters:=JSON Parse:C1218($json)
End if 
