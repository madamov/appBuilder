//%attributes = {}
// this should return path to Volume Desktop when building client on the same platform

#DECLARE->$path : Text

If (Is macOS)
	$path:=System folder(Documents folder)+"4D Client.app:"
End if 
If (Is Windows)
	$path:=System folder(Documents folder)+"4DCLIENT\\4D Client\\"
End if 
