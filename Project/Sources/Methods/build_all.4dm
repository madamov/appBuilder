//%attributes = {}
#DECLARE($config : Object)->$status : Object

var $compileStatus : Object
var $buildProjectPath; $oldErrorHandler; $buildLogPath : Text

$status:=New object
$status.success:=False

If (Position("BUILD_"; $config.action)>0)
	
	// ON ERR CALL("build_errorHandler")
	
	$buildProjectPath:=build_PrepareSettingsFile($config)
	
	logLineInLogEvent("Building using action: "+$config.action)
	logLineInLogEvent("Using build settings file: "+$buildProjectPath)
	
	If (Test path name($buildProjectPath)=Is a document)
		logLineInLogEvent("Build settings file exists: "+$buildProjectPath)
	Else 
		logLineInLogEvent("‼️ FATAL: build project file doesn't exist ‼️")
	End if 
	
	
	BUILD APPLICATION($buildProjectPath)
	
	// ON ERR CALL("")
	
	$buildLogPath:=Get 4D file(Build application log file)
	
	build_file2Artifacts($buildLogPath)
	
	If (OK=1)
		
		logLineInLogEvent("✅ Build success ✅")
		$status.success:=True
		
	Else 
		
		logLineInLogEvent("‼️ Build failure ‼️")
		
		build_dumpVar2File("build failed"; "status.log")
		
	End if 
	
	
End if 
