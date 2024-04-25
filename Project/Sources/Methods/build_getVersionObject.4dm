//%attributes = {}
#DECLARE()->$versionObj : Object

var $json : Text
var $versionFile : 4D.File


$versionFile:=File("/RESOURCES/version.json")

If ($versionFile.exists)
	$json:=$versionFile.getText()
	
	$versionObj:=JSON Parse($json)
	
End if 
