//%attributes = {}
// sets paths to developer licenses files in build XML setting file

#DECLARE($licenses : Collection; $xml : Text)->$new_xml : Text

var $xml_ref; $element_found; $itemCountRef; $itemCountName; \
$licenseRef; $licenseRefName; $licensePath; $elementPath : Text
var $itemCount; $i; $max : Integer

$new_xml:=$xml

$xml_ref:=DOM Parse XML variable:C720($xml)


If (OK=1)
	
	If (Is macOS:C1572)
		$elementPath:="/Preferences4D/BuildApp/Licenses/ArrayLicenseMac"
	Else 
		If (Is Windows:C1573)
			$elementPath:="/Preferences4D/BuildApp/Licenses/ArrayLicenseWin"
		End if 
	End if 
	
	$element_found:=DOM Find XML element:C864($xml_ref; $elementPath)
	$itemCountRef:=DOM Get first child XML element:C723($element_found; $itemCountName; $itemCount)
	
	For ($i; 1; $licenses.length)
		
		$licenseRef:=DOM Get next sibling XML element:C724($itemCountRef; $licenseRefName; $licensePath)
		
		
		If (OK=1)
		Else 
			$licenseRef:=DOM Create XML element:C865($xml_ref; $elementPath+$licenses[$i-1].elementName)
		End if 
		
		
		DOM SET XML ELEMENT VALUE:C868($licenseRef; $licenses[$i-1].path)
		
		$itemCountRef:=$licenseRef
		
		logLineInLogEvent("build: dev license path set to "+$licenses[$i-1].path)
		
	End for 
	
	DOM EXPORT TO VAR:C863($xml_ref; $new_xml)
	
	DOM CLOSE XML:C722($xml_ref)
	
	
End if 
