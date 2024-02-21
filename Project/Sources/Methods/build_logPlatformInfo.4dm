//%attributes = {}
// logs information about platform in operating system logs
// this line will be displayed in github actions output

If (Is Windows:C1573)
	logLineInLogEvent("4D running headless on Windows")
Else 
	If (Is macOS:C1572)
		logLineInLogEvent("4D running headless on macOS")
	Else 
		logLineInLogEvent("4D running headless on Linux?!")  // coming soon to the city nearby?
	End if 
End if 
