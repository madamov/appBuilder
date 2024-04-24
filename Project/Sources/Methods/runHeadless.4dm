//%attributes = {}
// performs tasks in headless mode: compiling, building, ...
// usually in GitHub actions runners

#DECLARE->$inHeadless : Boolean

var $getDBParValue : Real
var $startupParam; $oldErrorHandler; $myParams : Text
var $config; $status; $buildStatus; $compilerOptions : Object

$inHeadless:=Get application info.headless

If ($inHeadless)
	
	build_logPlatformInfo
	
	ON ERR CALL("build_errorHandler")
	
	$getDBParValue:=Get database parameter(User param value; $startupParam)
	
	If (Length($startupParam)>0)
		logLineInLogEvent("parsing user parameters passed to 4D\n"+$startupParam+"\n\n")
		If (Is Windows)
			// we use Base64 encoding to pass paramaters on Windows because of the spaces and special characters \
								 in JSON causing issues in Windows command prompt
			logLineInLogEvent("decoding parameters from Base64\n")
			BASE64 DECODE($startupParam; $myParams)
		Else 
			$myParams:=$startupParam
		End if 
		logLineInLogEvent("parsing final user parameters\n"+$myParams+"\n\n")
		$config:=JSON Parse($myParams)
		If ($config#Null)
			build_logMe("config not null")
			build_logMe("build number is: "+String($config.build))
		Else 
			build_logMe("It is null, quitting 4D later")
		End if 
	Else 
		logLineInLogEvent("no user parameters passed to 4D")
	End if 
	
	If ($config#Null)
		
		logLineInLogEvent("CONFIG not null")
		
		// which actions to take into account
		
		If (Is macOS)
			$config.action:=$config.actionMac
		Else 
			If (Is Windows)
				$config.action:=$config.actionWin
			Else 
				$config.action:=$config.actionOther
			End if 
		End if 
		
		If ($config.action=Null)
			$config.action:="RUN_ONLY"
		End if 
		
		// dump config action in artifacts
		
		build_dumpVar2File(JSON Stringify($config); "config_before.json")
		
		If (Position("RUN_ONLY"; $config.action)=0)  // ignore other actions if RUN_ONLY is present in string
			
			logLineInLogEvent("no run only action")
			
			If ($config.testSigning#Null)
				
				logLineInLogEvent("signing test")
				
				// called locally from mac to test
				
				$status:=build_CompileOnly
				
				If ($status.success)
					
					logLineInLogEvent("compiled ok")
					
					// ON ERR CALL("build_errorHandler")
					
					BUILD APPLICATION
					
					// ON ERR CALL("")
					
					If (OK=1)
						
						// build done ok
						logLineInLogEvent("BUILD ok")
						
					Else 
						
						// build failed
						logLineInLogEvent("‼️‼️ BUILD FAILED ‼️‼️")
						QUIT 4D
						
					End if 
					
				End if 
				
			Else 
				// always compile regardless of action we have to perform
				
				logLineInLogEvent("Compiling ...")
				
				$compilerOptions:=build_setCompilerOptions
				
				logLineInLogEvent("Compiler options set ...")
				
				$status:=build_CompileOnly($compilerOptions)
				
				logLineInLogEvent("Compiling done...")
				
				If ($status.success)
					
					logLineInLogEvent("Making version and build file")
					
					// build_makeVersionBuildFile
					
					logLineInLogEvent("Start building ...")
					
					$buildStatus:=build_all($config)
					
					If ($buildStatus.success)
						logLineInLogEvent("Building done OK...")
					End if 
					
				Else 
					
					// compilation failed, dump status file so github action will not run further
					
					build_dumpVar2File("compilation failed"; "status.log")
					
				End if 
				
				logLineInLogEvent("Quitting 4D")
				
				QUIT 4D
				
			End if 
			
		Else 
			
			// RUN_ONLY action present in user-params
			// return false to allow running in headless as headless server, do not QUIT 4D
			
			$inHeadless:=False
			
		End if 
		
	Else 
		
		logLineInLogEvent("No user-params present - quitting 4D ...")
		
		QUIT 4D
		
	End if 
	
	ON ERR CALL("")
	
Else 
	
	logLineInLogEvent("4D IS NOT IN HEADLESS MODE!!!")
	
End if 
