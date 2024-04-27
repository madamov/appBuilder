rem GET DEVELOPER LICENSES FROM SECRET AND PUT THEM IN LICENSES FOLDER
rem LEAVE THEM IN DOCUMENTS FOLDER FOR STANDALONE APP REFERENCE

mkdir %HOMEDRIVE%%HOMEPATH%\Documents\Licenses

powershell -command "Set-Content -Path %HOMEDRIVE%%HOMEPATH%\Downloads\dev_lic.b64 -Value $env:DEV_LIC"

certutil -decode %HOMEDRIVE%%HOMEPATH%\Downloads\dev_lic.b64 %HOMEDRIVE%%HOMEPATH%\Downloads\dev_lic.zip

dir /s %HOMEDRIVE%%HOMEPATH%\Documents\Licenses\*.* > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\licensedir1.txt

%sevenzip% x %HOMEDRIVE%%HOMEPATH%\Downloads\dev_lic.zip -o%HOMEDRIVE%%HOMEPATH%\Documents\Licenses\

dir /s %HOMEDRIVE%%HOMEPATH%\Documents\Licenses\*.* > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\licensedir2.txt

mkdir %ProgramData%\4D
mkdir %ProgramData%\4D\Licenses

copy /Y %HOMEDRIVE%%HOMEPATH%\Documents\Licenses\*.* %ProgramData%\4D\Licenses\

dir /s %ProgramData%\4D\Licenses\*.* > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\licensedir3.txt
