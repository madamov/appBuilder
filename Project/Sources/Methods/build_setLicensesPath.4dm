//%attributes = {}
// sets paths to developer licenses files in build XML setting file

#DECLARE($licenses : Collection; $xml : Text)->$new_xml : Text

var $xml_ref; $element_found; $itemCountRef; $itemCountName; \
$licenseRef; $licensePath; $elementPath : Text
var $itemCount; $i; $max : Integer

logLineInLogEvent("parsing settings file for licenses")

$xml_ref:=DOM Parse XML variable:C720($xml)

If (OK=1)
	
	logLineInLogEvent("got xml reference, parsed OK")
	
	$licenseRef:=DOM Find XML element:C864($xml_ref; "/Preferences4D/BuildApp/Licenses")
	If (OK=1)
		logLineInLogEvent("Licenses Element path found")
	Else   // create element in tree
		$licenseRef:=DOM Create XML element:C865($xml_ref; "/Preferences4D/BuildApp/Licenses")
		logLineInLogEvent("Licenses Element path created")
	End if 
	
	If (Is macOS:C1572)
		$elementPath:="/Preferences4D/BuildApp/Licenses/ArrayLicenseMac"
	Else 
		If (Is Windows:C1573)
			$elementPath:="/Preferences4D/BuildApp/Licenses/ArrayLicenseWin"
		End if 
	End if 
	
	logLineInLogEvent("Element path is: "+$elementPath)
	
	$element_found:=DOM Find XML element:C864($xml_ref; $elementPath)
	
	If (OK=1)
		logLineInLogEvent("Element path found: "+$elementPath)
	Else   // create element in tree
		$element_found:=DOM Create XML element:C865($xml_ref; $elementPath)
		logLineInLogEvent("Element path created: "+$elementPath)
	End if 
	
	$itemCountRef:=DOM Find XML element:C864($xml_ref; $elementPath+"/ItemsCount")
	
	If (OK=1)
		logLineInLogEvent("Element path found: "+$elementPath+"/ItemsCount")
	Else 
		$itemCountRef:=DOM Create XML element:C865($xml_ref; $elementPath+"/ItemsCount")
		logLineInLogEvent("Element path created: "+$elementPath+"/ItemsCount")
	End if 
	
	// DOM EXPORT TO VAR($xml_ref; $new_xml)
	// build_dumpVar2File($new_xml; "buildTemplateinSetLicenses.xml")  // dump it to artifacts folder for debugging
	
	DOM SET XML ELEMENT VALUE:C868($itemCountRef; $licenses.length)
	
	
	For ($i; 1; $licenses.length)
		
		$licenseRef:=DOM Find XML element:C864($xml_ref; $elementPath+"/Item"+String:C10($i))
		
		If (OK=1)
		Else 
			$licenseRef:=DOM Create XML element:C865($xml_ref; $elementPath+"/Item"+String:C10($i))
		End if 
		
		DOM SET XML ELEMENT VALUE:C868($licenseRef; $licenses[$i-1])
		
		logLineInLogEvent("build: dev license path set to "+$licenses[$i-1])
		
	End for 
	
	DOM EXPORT TO VAR:C863($xml_ref; $new_xml)
	logLineInLogEvent("XML var exported")
	
	DOM CLOSE XML:C722($xml_ref)
	logLineInLogEvent("XML closed")
	
End if 
