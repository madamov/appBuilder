echo "CMD:: Starting postBuild batch file ..."

set destFolder=%HOMEDRIVE%%HOMEPATH%\Documents\%destination%

if not x%action:BUILD_COMPILED_STRUCTURE=%==x%action% (
	@call %scripts%\release_structure.bat %destFolder% %build% %version%
)

if not x%action:BUILD_APP=%==x%action% (
	@call %scripts%\release_app.bat %destFolder% %build% %version%
)

echo "CMD:: Finishing postBuild batch file ..."
