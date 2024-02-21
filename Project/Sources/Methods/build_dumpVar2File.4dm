//%attributes = {}
// dumps the content of $texvar to a $filename in artifacts folder

#DECLARE($textvar : Text; $filename : Text)

var $path : Text

build_checkForArtifactsFolder

$path:=build_getPathToArtifacts+$filename

TEXT TO DOCUMENT:C1237($path; $textvar; "UTF-8")

logLineInLogEvent("Dumped to disk: "+$path)
