//%attributes = {}
//// builds standalone application or client and server applications based on config

//#DECLARE($config : Object)->$result : Object

//var $status : Object
//var $json; $buildProjectPath : Text

//logLineInLogEvent("build_ method called")

//Case of 


//: ($config.buildApp)

//If (Test path name(System folder(Documents folder)+"compiler")#Is a folder)
//CREATE FOLDER(System folder(Documents folder)+"compiler")
//End if 

//$status:=Compile project

//$json:=JSON Stringify($status; *)
//TEXT TO DOCUMENT(System folder(Documents folder)+"compiler"+Folder separator+"compiler_errors.json"; $json; "UTF-8")  // upload this via artifact upload github action

//If ($status.success)

//logLineInLogEvent("✅ Compilation success")

//$buildProjectPath:=build_PrepareSettingsFile($config)


//BUILD APPLICATION($buildProjectPath)

//If (OK=1)

//logLineInLogEvent("✅ Build success")

//Else 

//logLineInLogEvent("‼️ Build failure")

//End if 

//Else 

//logLineInLogEvent("‼️ Compile failure")

//End if 


//: ($config.buildCS)

//// todo

//If (Is Windows)
//// build windows server
//If ($config.buildClient)
//// modify buildApp.4DSettings to allow this
//If ($config.includeClients)
//// modify buildApp.4DSettings so the build process will do this
//// specify the path to other platform Volume Desktop location - in this case location of macOS Volume Desktop
//End if 
//End if 
//Else 
//If (Is macOS)
//// build Mac server
//If ($config.buildClient)
//// modify buildApp.4DSettings to allow this
//If ($config.includeClients)
//// modify buildApp.4DSettings so the build process will do this
//// specify the path to other platform Volume Desktop location - in this case location of Windows Volume Desktop
//End if 
//End if 
//End if 
//End if 


//End case 
