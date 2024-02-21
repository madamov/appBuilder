//%attributes = {}
// logs one line in system log in host operating system

#DECLARE($msg : Text)

If (Is Windows:C1573)
	LOG EVENT:C667(Into Windows log events:K38:4; $msg)
End if 

$msg:="4️⃣🇩:: "+$msg

LOG EVENT:C667(Into system standard outputs:K38:9; $msg+"\n")

// log to artifacts

build_logMe($msg)
