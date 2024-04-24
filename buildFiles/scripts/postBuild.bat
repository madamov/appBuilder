echo "CMD:: Starting postBuild batch file ..."

if not x%action:BUILD_COMPILED_STRUCTURE=%==x%action% (
	@call %scripts%\release_structure.bat %destFolder% %build% %version%
)

if not x%action:BUILD_APP=%==x%action% (
	@call %scripts%\release_app.bat %destFolder% %build% %version%
)

if not x%action:BUILD_SERVER=%==x%action% (
	@call %scripts%\release_server.bat %destFolder% %build% %version%
)

if not x%action:BUILD_CLIENT=%==x%action% (
	@call %scripts%\release_client.bat %destFolder% %build% %version%
)

echo "CMD:: Finishing postBuild batch file ..."

dir /s %HOMEDRIVE%%HOMEPATH%\Documents\*.* > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\dirlisting_documents.txt
