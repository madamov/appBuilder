//%attributes = {}
#DECLARE->$path : Text

var $params : Object

$params:=build_getCurrentParameters

If (Is macOS:C1572)
	$path:=System folder:C487(Documents folder:K41:18)+String:C10($params.build)+Folder separator:K24:12+"4D Client.app:"
End if 
If (Is Windows:C1573)
	$path:=System folder:C487(Documents folder:K41:18)+String:C10($params.build)+Folder separator:K24:12+"4DCLIENT\\4D Client\\"
End if 
