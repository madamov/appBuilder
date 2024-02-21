//%attributes = {}
#DECLARE($msg : Text)


CALL WORKER:C1389("build_logger"; "build_logWorker"; $msg)
