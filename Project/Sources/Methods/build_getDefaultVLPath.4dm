//%attributes = {}
#DECLARE->$path : Text

If (Is macOS:C1572)
	$path:=System folder:C487(Documents folder:K41:18)+"4D Volume Desktop.app:"
End if 
If (Is Windows:C1573)
	$path:=System folder:C487(Documents folder:K41:18)+"4DVL\\4D Volume Desktop\\"
End if 
