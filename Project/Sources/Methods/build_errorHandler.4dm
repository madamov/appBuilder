//%attributes = {}
C_LONGINT(Error; $i)
C_TEXT(Error method; Error formula)

var $output; $errorMsg; $filename : Text
var $inHeadless : Boolean

$output:="Build error: "+String(Error)+"\nBuild error method: "+Error method+"\nBuild error formula: "+Error formula

$errorMsg:="Errors building, check build_errors.txt file(s) in artifacts folder"

$filename:="build_errors_"+String(Tickcount)+".txt"

ARRAY LONGINT($codes; 0)
ARRAY TEXT($internal; 0)
ARRAY TEXT($textArr; 0)

GET LAST ERROR STACK($codes; $internal; $textArr)

For ($i; 1; Size of array($codes))
	$output:=$output+"\nStack "+String($i)+": "+String($codes{$i})+Char(Tab)+$internal{$i}+Char(Tab)+$textArr{$i}
End for 

logLineInLogEvent($output)
build_dumpVar2File($output; $filename)


$inHeadless:=Get application info.headless

If ($inHeadless)
	logLineInLogEvent($errorMsg)
	build_dumpVar2File("build failed in error handler\n\n"+$output; "status.log")
	QUIT 4D
Else 
	ALERT($errorMsg)
End if 
