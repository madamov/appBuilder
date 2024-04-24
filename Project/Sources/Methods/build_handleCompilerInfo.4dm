//%attributes = {}
// dumps compiler information to disk files for upload by artifacts github actions to pick them up
// and/or uploading back to us

#DECLARE($status : Object)

var $json; $statusFileName : Text
var $warnings : Collection

If ($status.success)
	
	If ($status.errors#Null:C1517)
		If ($status.errors.length>0)
			$json:=JSON Stringify:C1217($status.errors; *)
			$statusFileName:="compiler_warnings.json"
			build_dumpVar2File($json; $statusFileName)
		End if 
	End if 
	
Else 
	
	$json:=JSON Stringify:C1217($status.errors.query("isError = :1"; True:C214); *)
	logLineInLogEvent($json)  // display errors only in console
	$statusFileName:="compiler_errors.json"
	build_dumpVar2File($json; $statusFileName)
	
	$warnings:=$status.errors.query("isError = :1"; False:C215)
	$json:=JSON Stringify:C1217($warnings; *)
	$statusFileName:="compiler_warnings.json"
	build_dumpVar2File($json; $statusFileName)
	
End if 


If (False:C215)  // old code
	
	If ($status.success)
		If ($status.errors#Null:C1517)
			If ($status.errors.length>0)
				build_checkForArtifactsFolder
				$json:=JSON Stringify:C1217($status.errors; *)
				$statusFileName:="compiler_warnings.json"
				TEXT TO DOCUMENT:C1237(System folder:C487(Documents folder:K41:18)+"artifacts"+Folder separator:K24:12+$statusFileName; $json; "UTF-8")  // upload this via artifact upload github action
			End if 
		End if 
	Else 
		build_checkForArtifactsFolder
		$json:=JSON Stringify:C1217($status.errors.query("isError = :1"; True:C214); *)
		logLineInLogEvent($json)  // display errors only in console
		$statusFileName:="compiler_errors.json"
		TEXT TO DOCUMENT:C1237(System folder:C487(Documents folder:K41:18)+"artifacts"+Folder separator:K24:12+$statusFileName; $json; "UTF-8")  // upload this via artifact upload github action
		$warnings:=$status.errors.query("isError = :1"; False:C215)
		$json:=JSON Stringify:C1217($warnings; *)
		$statusFileName:="compiler_warnings.json"
		TEXT TO DOCUMENT:C1237(System folder:C487(Documents folder:K41:18)+"artifacts"+Folder separator:K24:12+$statusFileName; $json; "UTF-8")
	End if 
	
End if 
