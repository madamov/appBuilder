rem GET DEVELOPER LICENSES

echo "getting licenses from %1%"

curl -s -u %BINARIES_USER%:%BINARIES_PASSWORD% -o %HOMEDRIVE%%HOMEPATH%\Downloads\dev_lic.zip %1%


mkdir %HOMEDRIVE%%HOMEPATH%\Documents\%nextbuildnumber%\Licenses

dir /s %HOMEDRIVE%%HOMEPATH%\Documents\%nextbuildnumber%\Licenses\*.* > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\licensedir1.txt

%sevenzip% x %HOMEDRIVE%%HOMEPATH%\Downloads\dev_lic.zip -o%HOMEDRIVE%%HOMEPATH%\Documents\%nextbuildnumber%\Licenses\

dir /s %HOMEDRIVE%%HOMEPATH%\Documents\%nextbuildnumber%\Licenses\*.* > %HOMEDRIVE%%HOMEPATH%\Documents\%nextbuildnumber%\artifacts\licensedir2.txt

mkdir %ProgramData%\4D
mkdir %ProgramData%\4D\Licenses

copy /Y %HOMEDRIVE%%HOMEPATH%\Documents\%nextbuildnumber%\Licenses\*.* %ProgramData%\4D\Licenses\

dir /s %ProgramData%\4D\Licenses\*.* > %HOMEDRIVE%%HOMEPATH%\Documents\%nextbuildnumber%\artifacts\licensedir1.txt
