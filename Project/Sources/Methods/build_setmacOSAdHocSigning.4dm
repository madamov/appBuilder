//%attributes = {}
#DECLARE($signingParams : Object; $xml : Text)->$new_xml : Text

var $xml_ref; $element_found : Text
var $signAppRef; $macSignatureRef; $adHocSignRef; $certificateNameRef : Text

logLineInLogEvent("parsing settings file for AdHoc signing")

$xml_ref:=DOM Parse XML variable:C720($xml)

If (OK=1)
	
	$signAppRef:=DOM Find XML element:C864($xml_ref; "/Preferences4D/BuildApp/SignApplication")
	If (OK=1)
		logLineInLogEvent("SignApplication Element path found")
	Else   // create element in tree
		$signAppRef:=DOM Create XML element:C865($xml_ref; "/Preferences4D/BuildApp/SignApplication")
		logLineInLogEvent("SignApplication Element path created")
	End if 
	
	$macSignatureRef:=DOM Find XML element:C864($xml_ref; "/Preferences4D/BuildApp/SignApplication/MacSignature")
	If (OK=1)
		logLineInLogEvent("MacSignature Element path found")
	Else   // create element in tree
		$macSignatureRef:=DOM Create XML element:C865($xml_ref; "/Preferences4D/BuildApp/SignApplication/MacSignature")
		logLineInLogEvent("MacSignature Element path created")
	End if 
	
	DOM SET XML ELEMENT VALUE:C868($macSignatureRef; $signingParams.sign)
	
	$adHocSignRef:=DOM Find XML element:C864($xml_ref; "/Preferences4D/BuildApp/SignApplication/AdHocSign")
	If (OK=1)
		logLineInLogEvent("MacSignature Element path found")
	Else   // create element in tree
		$adHocSignRef:=DOM Create XML element:C865($xml_ref; "/Preferences4D/BuildApp/SignApplication/AdHocSign")
		logLineInLogEvent("MacSignature Element path created")
	End if 
	
	DOM SET XML ELEMENT VALUE:C868($adHocSignRef; $signingParams.adHoc)
	
	$certificateNameRef:=DOM Find XML element:C864($xml_ref; "/Preferences4D/BuildApp/SignApplication/MacCertificate")
	If (OK=1)
		logLineInLogEvent("MacSignature Element path found")
	Else   // create element in tree
		$certificateNameRef:=DOM Create XML element:C865($xml_ref; "/Preferences4D/BuildApp/SignApplication/MacCertificate")
		logLineInLogEvent("MacSignature Element path created")
	End if 
	
	DOM SET XML ELEMENT VALUE:C868($certificateNameRef; $signingParams.certificateName)
	
	DOM EXPORT TO VAR:C863($xml_ref; $new_xml)
	logLineInLogEvent("XML var exported")
	
	DOM CLOSE XML:C722($xml_ref)
	logLineInLogEvent("XML closed")
	
End if 
