//%attributes = {}
// location of Windows Volume Desktop when building windows client archive on macOS

#DECLARE->$path : Text

If (Is macOS)
	$path:=System folder(Documents folder)+"4D_VL_WIN:4D Volume Desktop:"
End if 
