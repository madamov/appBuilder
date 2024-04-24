//%attributes = {}
// we use artifacts folder to attach logs, information or similar from each build
// we use upload-artifact@v3 github action to zip this folder and "upload" at the end of build process
// github actions will keep those for 90 days
// this methods checks if folder exists and it creates it if not
// added error handling ignore because at some clients there is an error displayed, eventhough this method
// should run during automated build process and in headless mode only

#DECLARE->$path : Text

var $prevErrorHandler : Text

$prevErrorHandler:=Method called on error

ON ERR CALL("Err_ignore")

If (Test path name(System folder(Documents folder)+"artifacts")#Is a folder)
	CREATE FOLDER(System folder(Documents folder)+"artifacts")
	$path:=System folder(Documents folder)+"artifacts"
End if 

ON ERR CALL($prevErrorHandler)
