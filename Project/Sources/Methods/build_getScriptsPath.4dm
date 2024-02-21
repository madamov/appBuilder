//%attributes = {}
// returns path to a scripts we run in runners on github

#DECLARE->$path : Text

var $database; $buildFolder : Object

$database:=Folder:C1567(fk database folder:K87:14)

$buildFolder:=Folder:C1567($database.platformPath+"buildFiles"+Folder separator:K24:12+"scripts"; fk platform path:K87:2)

$path:=$buildFolder.platformPath

