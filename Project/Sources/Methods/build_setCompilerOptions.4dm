//%attributes = {}
#DECLARE()->$options : Object

$options:=New object:C1471

$options.targets:=New collection:C1472("x86_64_generic")

$options.typeInference:="none"  // all variables are typed

$options.defaultTypeForNumerics:=Is real:K8:4
$options.defaultTypeForButtons:=Is longint:K8:6

$options.generateSymbols:=True:C214

// $options.generateTypingMethods:="reset" // 4D bug maybe, compilation always with errors
$options.generateTypingMethods:="append"
