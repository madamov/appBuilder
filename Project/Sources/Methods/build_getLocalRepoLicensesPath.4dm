//%attributes = {}
// candidate for deletion after fully implemented new building process

// returns path to local licenses folder in repo
// we use that for local testing without running headless

#DECLARE->$path : Text

var $database; $buildFolder : Object

$database:=Folder:C1567(fk database folder:K87:14)

If (UTIL_is4DFeatureRelease)
	$buildFolder:=Folder:C1567($database.platformPath+"buildFiles"+Folder separator:K24:12+"licensesR"; fk platform path:K87:2)
Else 
	$buildFolder:=Folder:C1567($database.platformPath+"buildFiles"+Folder separator:K24:12+"licenses"; fk platform path:K87:2)
End if 
$path:=$buildFolder.platformPath

