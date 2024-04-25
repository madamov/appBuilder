//%attributes = {}
#DECLARE->$path : Text

If (Is macOS)
	$path:=System folder(Documents folder)+"4D Server.app:"
End if 
If (Is Windows)
	$path:=System folder(Documents folder)+"4D_SERVER\\4D Server\\"
End if 
