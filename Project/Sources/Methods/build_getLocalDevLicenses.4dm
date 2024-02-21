//%attributes = {}
// prepares collection of paths to 4D Developer Professional license files

#DECLARE($licensesPath : Text)->$licenses : Collection

var $i : Integer

If (Count parameters=0)
	$licensesPath:=System folder(Documents folder)+"Licenses"+Folder separator
End if 

ARRAY TEXT($files; 0)

DOCUMENT LIST($licensesPath; $files)

$licenses:=New collection

If (True)
	
	For ($i; 1; Size of array($files))
		If ($files{$i}[[1]]#".")
			$licenses.push($licensesPath+$files{$i})
		End if 
	End for 
	
Else 
	
	// OLD CODE
	
	//var $idx : Integer
	
	//$idx:=1
	
	//For ($i; 1; Size of array($files))
	//If ($files{$i}[[1]]#".")
	//$licenses.push(New object("elementName"; "Item"+String($idx); "path"; $licensesPath+$files{$i}))
	//$idx:=$idx+1
	//End if 
	//End for 
	
End if 
