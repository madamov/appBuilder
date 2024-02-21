//%attributes = {}
// returns the XML contents of build settings template file
// it returns contents of default 4D settings file if $path is not passed

#DECLARE($path : Text)->$xml : Text

If (Count parameters=0)
	
	$path:=build_getTemplatePath
	
End if 

If (Test path name($path)=Is a document)
	
	$xml:=Document to text($path; "UTF-8")
	
End if 


