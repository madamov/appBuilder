//%attributes = {}
#DECLARE($signingParams : Object; $xml : Text)->$new_xml : Text

var $xml_ref; $element_found : Text
var $signAppRef; $macSignatureRef; $adHocSignRef; $certificateNameRef : Text

logLineInLogEvent("parsing settings file signing")

$xml_ref:=DOM Parse XML variable($xml)

If (OK=1)
	
	$signAppRef:=DOM Find XML element($xml_ref; "/Preferences4D/BuildApp/SignApplication")
	If (OK=1)
		logLineInLogEvent("SignApplication Element path found")
	Else   // create element in tree
		$signAppRef:=DOM Create XML element($xml_ref; "/Preferences4D/BuildApp/SignApplication")
		logLineInLogEvent("SignApplication Element path created")
	End if 
	
	$macSignatureRef:=DOM Find XML element($xml_ref; "/Preferences4D/BuildApp/SignApplication/MacSignature")
	If (OK=1)
		logLineInLogEvent("MacSignature Element path found")
	Else   // create element in tree
		$macSignatureRef:=DOM Create XML element($xml_ref; "/Preferences4D/BuildApp/SignApplication/MacSignature")
		logLineInLogEvent("MacSignature Element path created")
	End if 
	
	DOM SET XML ELEMENT VALUE($macSignatureRef; $signingParams.MacSignature)
	
	$adHocSignRef:=DOM Find XML element($xml_ref; "/Preferences4D/BuildApp/SignApplication/AdHocSign")
	If (OK=1)
		logLineInLogEvent("MacSignature Element path found")
	Else   // create element in tree
		$adHocSignRef:=DOM Create XML element($xml_ref; "/Preferences4D/BuildApp/SignApplication/AdHocSign")
		logLineInLogEvent("MacSignature Element path created")
	End if 
	
	DOM SET XML ELEMENT VALUE($adHocSignRef; $signingParams.AdHocSign)
	
	$certificateNameRef:=DOM Find XML element($xml_ref; "/Preferences4D/BuildApp/SignApplication/MacCertificate")
	If (OK=1)
		logLineInLogEvent("MacSignature Element path found")
	Else   // create element in tree
		$certificateNameRef:=DOM Create XML element($xml_ref; "/Preferences4D/BuildApp/SignApplication/MacCertificate")
		logLineInLogEvent("MacSignature Element path created")
	End if 
	
	DOM SET XML ELEMENT VALUE($certificateNameRef; $signingParams.MacCertificate)
	
	DOM EXPORT TO VAR($xml_ref; $new_xml)
	logLineInLogEvent("XML var exported")
	
	DOM CLOSE XML($xml_ref)
	logLineInLogEvent("XML closed")
	
End if 
