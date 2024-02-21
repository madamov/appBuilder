//%attributes = {}
// copies structure settings file to Project folder

#DECLARE->$status : Object

var $buildFilesFolder; $projectFolder : 4D.Folder
var $defaultSettingsFile; $settingsFile : 4D.File
var $structPath : Object

$buildFilesFolder:=build_getBuildFilesFolder
$structPath:=getServerStructurePathObject
$projectFolder:=Folder($structPath.parentFolder; fk platform path)

$defaultSettingsFile:=File($buildFilesFolder.platformPath+"Default_settings.4DSettings"; fk platform path)

If ($defaultSettingsFile.exists)
	$status:=New object("success"; True)
	$settingsFile:=$defaultSettingsFile.copyTo($projectFolder; "settings.4DSettings"; fk overwrite)
Else 
	$status:=New object("success"; False)
End if 
