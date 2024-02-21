//%attributes = {}
// sets path to built application or client server apps
// sets the destination folder for built application in in build XML settings file

#DECLARE($destPath : Text; $xml : Text)->$new_xml : Text


var $xml_ref; $elementPath; $element_found : Text

$xml_ref:=DOM Parse XML variable($xml)


If (OK=1)
	
	If (Is macOS)
		$elementPath:="/Preferences4D/BuildApp/BuildMacDestFolder/"
	Else 
		If (Is Windows)
			$elementPath:="/Preferences4D/BuildApp/BuildWinDestFolder/"
		End if 
	End if 
	
	$element_found:=DOM Find XML element($xml_ref; $elementPath)
	
	If (OK=1)
	Else 
		$element_found:=DOM Create XML element($xml_ref; $elementPath)
	End if 
	
	DOM SET XML ELEMENT VALUE($element_found; $destPath)
	
	logLineInLogEvent("Destination path set: "+$destPath)
	
	DOM EXPORT TO VAR($xml_ref; $new_xml)
	
	DOM CLOSE XML($xml_ref)
	
End if 
