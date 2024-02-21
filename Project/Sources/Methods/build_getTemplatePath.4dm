//%attributes = {}
// returns path to a build settings template file we are going to build our own from

#DECLARE->$path : Text

var $database; $buildFolder : Object

$database:=Folder:C1567(fk database folder:K87:14)

$buildFolder:=Folder:C1567($database.platformPath+"buildFiles"+Folder separator:K24:12+"build_settings"; fk platform path:K87:2)

$path:=$buildFolder.platformPath+"template.4DSettings"
