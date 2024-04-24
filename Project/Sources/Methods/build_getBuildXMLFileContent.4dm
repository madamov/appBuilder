//%attributes = {}
// returns the XML contents of build settings template file
// it returns contents of default 4D settings file if $path is not passed

#DECLARE($path : Text)->$xml : Text

If (Count parameters:C259=0)
	
	$path:=build_getTemplatePath
	
End if 

If (Test path name:C476($path)=Is a document:K24:1)
	
	$xml:=Document to text:C1236($path; "UTF-8")
	
End if 
