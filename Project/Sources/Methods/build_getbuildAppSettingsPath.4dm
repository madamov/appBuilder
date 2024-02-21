//%attributes = {}
// NOT USED ANYMORE

// returns path to default build preferences XML file

C_OBJECT:C1216($path; $path1)
C_TEXT:C284($0)

$path:=Path to object:C1547(Structure file:C489; Path is system:K24:25)
$path1:=Path to object:C1547($path.parentFolder; Path is system:K24:25)


$0:=$path1.parentFolder+"Settings"+Folder separator:K24:12+"buildApp.4DSettings"  // for v19
