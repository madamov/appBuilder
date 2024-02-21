//%attributes = {}
#DECLARE($msg : Text)

var $doc : Time
var $path : Text

$path:=build_getPathToArtifacts+"log4D.txt"

If (Test path name:C476($path)#Is a document:K24:1)
	$doc:=Create document:C266($path)
Else 
	$doc:=Append document:C265($path)
End if 

If (OK=1)
	
	SEND PACKET:C103($doc; Timestamp:C1445+Char:C90(Tab:K15:37)+$msg+"\n")
	
	CLOSE DOCUMENT:C267($doc)
	
End if 
