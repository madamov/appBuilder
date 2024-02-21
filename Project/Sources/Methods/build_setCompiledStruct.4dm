//%attributes = {}
#DECLARE($xml : Text; $setBuildCompiled : Boolean; $setIncludeAssociatedFolders : Boolean)->$new_xml : Text

var $xml_ref; $element_found; $elementPath : Text


$xml_ref:=DOM Parse XML variable:C720($xml)

If (OK=1)
	
	If (Count parameters:C259=0)
		$setBuildCompiled:=True:C214
		$setIncludeAssociatedFolders:=True:C214
	Else 
		If (Count parameters:C259=1)
			$setIncludeAssociatedFolders:=True:C214
		End if 
	End if 
	
	$elementPath:="/Preferences4D/BuildApp/BuildCompiled/"
	
	$element_found:=DOM Find XML element:C864($xml_ref; $elementPath)
	
	If (OK=1)
	Else 
		$element_found:=DOM Create XML element:C865($xml_ref; $elementPath)
	End if 
	
	If ($setBuildCompiled)
		DOM SET XML ELEMENT VALUE:C868($element_found; "True")
	Else 
		DOM SET XML ELEMENT VALUE:C868($element_found; "False")
	End if 
	
	$elementPath:="/Preferences4D/BuildApp/IncludeAssociatedFolders/"
	
	$element_found:=DOM Find XML element:C864($xml_ref; $elementPath)
	
	If (OK=1)
	Else 
		$element_found:=DOM Create XML element:C865($xml_ref; $elementPath)
	End if 
	
	If ($setBuildCompiled)
		DOM SET XML ELEMENT VALUE:C868($element_found; "True")
	Else 
		DOM SET XML ELEMENT VALUE:C868($element_found; "False")
	End if 
	
	
	DOM EXPORT TO VAR:C863($xml_ref; $new_xml)
	
	DOM CLOSE XML:C722($xml_ref)
	
	
End if 

