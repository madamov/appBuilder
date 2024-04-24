//%attributes = {}
// sets StartElevated to true in build XML settings file

#DECLARE($xml : Text)->$new_xml : Text

var $xml_ref; $elementPath; $element_found : Text


$xml_ref:=DOM Parse XML variable($xml)


If (OK=1)
	
	$elementPath:="/Preferences4D/BuildApp/StartElevated/"
	$element_found:=DOM Find XML element($xml_ref; $elementPath)
	
	If (OK=1)
	Else 
		$element_found:=DOM Create XML element($xml_ref; $elementPath)
	End if 
	
	DOM SET XML ELEMENT VALUE($element_found; "True")
	
	DOM EXPORT TO VAR($xml_ref; $new_xml)
	
	DOM CLOSE XML($xml_ref)
	
End if 