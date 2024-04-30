//%attributes = {}
// prepares build settings file which will be passed to BUILD APPLICATION command later
// returns full path to resulting build settings file - we have to pass that path to BUILD APPLICATION command

#DECLARE($parameters : Object)->$path : Text

// $parameters.action - actions to perform: \
BUILD_APP#COMPILE_ONLY#BUILD_COMPILED_STRUCTURE#BUILD_SERVER#BUILD_CLIENT#INCLUDE_CLIENT#INCLUDE_MAC_CLIENT#INCLUDE_WIN_CLIENT#RUN_ONLY
// $parameters.buildSettingsFileName - file name of build setting s file we will pass to BUILD APPLICATION command
// $parameters.templatePath - path to build settings XML template file we are going to build our build settings from
// $parameters.pathToLicenses - path to a folder containing developer licenses needed to perform compilation and/or building of application or compiled structure
// $parameters.destinationPath - path to folder where 4D will put built applications or compiled structure or components
// $parameters.appName - final application name if action is BUILD
// $parameters.pathToServer - path to 4D Server executable package/folder
// $parameters.pathToClient - path to 4D Client
// $parameters.pathToVL - path to folder containing 4D Volume License package for current runner platform
// $parameters.pathToWindowsVL - path to folder containing 4D Volume license package for other platform - macOS only when INCLUDE_WINDOWS_CLIENT is used
// $parameters.pathToMacArchive - URL to get macOS 4D Client archive within Windows runner from artifacts of previously finished macOS runner when INCLUDE_MAC_CLIENT is used


var $localDevLicensePaths : Collection
var $old_xml; $new_xml; $oneaction : Text
var $projectFolder; $signingObject : Object
var $actions : Collection
var $buildClientOn : Boolean

logLineInLogEvent("Preparing settings file ...")

$projectFolder:=Folder(fk database folder)

If ($parameters=Null)
	$parameters:=New object
	$parameters.action:="RUN_ONLY"
End if 

$buildClientOn:=False

$actions:=Split string($parameters.action; "#")

If ($parameters.buildSettingsFileName=Null)
	$parameters.buildSettingsFileName:="buildApp.4DSettings"
End if 

$path:=System folder(Documents folder)+$parameters.buildSettingsFileName

logLineInLogEvent("Build settings file path is "+$path)

// common code for building settings file regardless of action

If ($parameters.templatePath=Null)
	$parameters.templatePath:=build_getTemplatePath
	logLineInLogEvent("Got template path "+$parameters.templatePath)
Else 
	If (Is macOS)
		$parameters.templatePath:=Convert path POSIX to system($parameters.templatePath)
	End if 
End if 

logLineInLogEvent("Getting XML content from "+$parameters.templatePath)

$old_xml:=build_getBuildXMLFileContent($parameters.templatePath)

build_dumpVar2File($old_xml; "buildTemplateAtStart.xml")  // dump template file to artifacts folder for debugging

If ($parameters.pathToLicenses=Null)
	$parameters.pathToLicenses:=System folder(Documents folder)+"Licenses"+Folder separator
Else 
	If (Is macOS)
		$parameters.pathToLicenses:=Convert path POSIX to system($parameters.pathToLicenses)
	End if 
End if 

logLineInLogEvent("Getting dev licenses from "+$parameters.pathToLicenses)

$localDevLicensePaths:=build_getLocalDevLicenses($parameters.pathToLicenses)

logLineInLogEvent("Setting dev licenses path")

$new_xml:=build_setLicensesPath($localDevLicensePaths; $old_xml)

build_dumpVar2File($new_xml; "new_withlicenses.xml")

If ($parameters.destinationPath=Null)
	$parameters.destinationPath:=System folder(Documents folder)+"MyBuild"+Folder separator
Else 
	If (Is macOS)
		$parameters.destinationPath:=Convert path POSIX to system($parameters.destinationPath)
	End if 
End if 

logLineInLogEvent("Setting destination path to: "+$parameters.destinationPath)

$new_xml:=build_setDestinationPath($parameters.destinationPath; $new_xml)

If ($parameters.appName=Null)
	$parameters.appName:="DefaultAppName"
End if 

$new_xml:=build_setAppName($parameters.appName; $new_xml)

logLineInLogEvent("App name set to "+$parameters.appName)

// always set VL path even if we don't need it afterwards
// in order not to call Convert path POSIX to system twice on the path

If ($parameters.pathToVL=Null)
	$parameters.pathToVL:=build_getDefaultVLPath
Else 
	If (Is macOS)
		$parameters.pathToVL:=Convert path POSIX to system($parameters.pathToVL)
	End if 
End if 

If (Is macOS)
	
	If ($parameters.macOS.signing#Null) && ($parameters.macOS.signing.sign#Null)
		
		$signingObject:=New object
		$signingObject.MacSignature:="False"
		$signingObject.MacCertificate:=""
		$signingObject.AdHocSign:="False"
		
		If ($parameters.macOS.signing.adHoc#Null) && ($parameters.macOS.signing.adHoc="True")
			$signingObject.AdHocSign:="True"
		End if 
		
		If ($parameters.macOS.signing.sign="True") && ($parameters.macOS.signing.certificateName#Null)
			$signingObject.MacSignature:="True"
			$signingObject.MacCertificate:=$parameters.macOS.signing.certificateName
			$new_xml:=build_setmacOSSigning($signingObject; $new_xml)
		End if 
		
	End if 
	
End if 

//========================================================
// action specific settings in build file

For each ($oneaction; $actions)
	
	logLineInLogEvent("Checking action "+$oneaction)
	
	If ($oneaction="BUILD_COMPILED_STRUCTURE")
		
		logLineInLogEvent("Setting XML for building compiled structure")
		
		$new_xml:=build_setCompiledStruct($new_xml; True; True)
		
	End if 
	
	
	If ($oneaction="BUILD_APP")
		
		logLineInLogEvent("Setting XML for build app")
		
		$new_xml:=build_setBuildAppSerialized($new_xml)  // set BuildApplicationSerialized to True
		
		logLineInLogEvent("Serialized set")
		
		$new_xml:=build_setVLLocation($parameters.pathToVL; $new_xml)
		
		logLineInLogEvent("Setting Volume License location to "+$parameters.pathToVL)
		
	End if 
	
	
	If ($oneaction="BUILD_SERVER")
		
		logLineInLogEvent("Setting XML to build Server")
		
		If ($parameters.pathToServer=Null)
			$parameters.pathToServer:=build_getDefaultServerPath
		Else 
			If (Is macOS)
				$parameters.pathToServer:=Convert path POSIX to system($parameters.pathToServer)
			End if 
		End if 
		
		$new_xml:=build_setBuildServerApplication($new_xml)
		
		$new_xml:=build_setServerLocation($parameters.pathToServer; $new_xml)
		
		$new_xml:=build_setServerEmbedsProjectDir($new_xml)  // set ServerEmbedsProjectDirectoryFile to True
		
		$new_xml:=build_setCurrentVers($new_xml; Num($parameters.build))  // set CurrentVers to build number we are currently building
		
		$new_xml:=build_setLastDataPathLookup($new_xml)  // set LastDataPathLookup to True
		
	End if 
	
	If ($oneaction="BUILD_CLIENT")
		
		$buildClientOn:=True  // allow building of clients and including them for automatic update
		
		$new_xml:=build_setClientLocation($parameters.pathToVL; $new_xml)
		
	End if 
	
	If (($oneaction="INCLUDE_CLIENT") & $buildClientOn)
		
		$new_xml:=build_setBuildCSUpgradeable($new_xml)  // set BuildCSUpgradeable to True
		
	End if 
	
	If (($oneaction="INCLUDE_WIN_CLIENT") & $buildClientOn)  // include Windows client on mac
		If (Is macOS)  // we do this only on macOS
			$new_xml:=build_setBuildCSUpgradeable($new_xml)  // set BuildCSUpgradeable to True
			If ($parameters.pathToWindowsVL=Null)
				$parameters.pathToWindowsVL:=build_getDefaultWinVLPathOnMac
			Else 
				$parameters.pathToWindowsVL:=Convert path POSIX to system($parameters.pathToWindowsVL)
			End if 
			$new_xml:=build_setClientWinFolderToMac($parameters.pathToWindowsVL; $new_xml)
		End if 
	End if 
	
	If (($oneaction="INCLUDE_MAC_CLIENT") & $buildClientOn)  // include Mac client on Windows
		If (Is Windows)
			$new_xml:=build_setBuildCSUpgradeable($new_xml)  // set BuildCSUpgradeable to True
			If ($parameters.pathToMacArchive=Null)
				$parameters.pathToMacArchive:=build_getDefaultMacArchivePath
			End if 
			$new_xml:=build_setClientMacFolderToWin($parameters.pathToMacArchive; $new_xml)
		End if 
	End if 
	
End for each 

TEXT TO DOCUMENT($path; $new_xml; "UTF-8")  // put build setting file to a location 4D expect it to build application

build_dumpVar2File($new_xml; "buildApp_fromXMLVar.4DSettings")  // dump setting to artifacts folder for debugging

build_file2Artifacts($path)  // copy 4DSettings file to artifacts
