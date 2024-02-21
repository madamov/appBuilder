//%attributes = {}
// compiles project

#DECLARE($compileOptions : Object)->$status : Object

If (Count parameters=0)
	logLineInLogEvent("Compiling with default compiler options")
	$status:=Compile project
Else 
	logLineInLogEvent("Compiling with custom compiler options")
	logLineInLogEvent(JSON Stringify($compileOptions; *))
	$status:=Compile project($compileOptions)
End if 

logLineInLogEvent("Handling post compiling information")
build_handleCompilerInfo($status)
logLineInLogEvent("Done handling post compiling information")

If ($status.success)
	logLineInLogEvent("✅ Compilation successfull ✅\n")
Else 
	logLineInLogEvent("‼️ Compilation failure ‼️\n")
End if 
