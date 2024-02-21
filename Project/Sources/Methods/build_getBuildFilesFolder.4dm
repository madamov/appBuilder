//%attributes = {}
#DECLARE->$buildFilesFolder : 4D.Folder

var $databaseFolder : 4D.Folder

$databaseFolder:=Folder(fk database folder)

$buildFilesFolder:=Folder($databaseFolder.platformPath+"buildFiles"; fk platform path)
