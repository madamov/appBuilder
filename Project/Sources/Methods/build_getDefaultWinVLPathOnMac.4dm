//%attributes = {}
// location of Windows Volume Desktop when building windows client archive on macOS

#DECLARE->$path : Text

If (Is macOS:C1572)
	$path:=System folder:C487(Documents folder:K41:18)+"4DVL:4D Client:4D Volume Desktop:"
End if 
