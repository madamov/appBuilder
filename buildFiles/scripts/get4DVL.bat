rem download 4D Volume Desktop, leave it in Documents folder, we will refer to it in buildApp.4DSettings XML file

echo "BAT: Downloading 4D Volume Desktop Windows ..."
curl -s -u %BINARIES_USER%:%BINARIES_PASSWORD% -o %HOMEDRIVE%%HOMEPATH%\Downloads\4D_VL_win.zip %1%
echo "BAT: 4D Volume Desktop Windows downloaded, unzipping archive ..."
mkdir %HOMEDRIVE%%HOMEPATH%\Documents\4DVL
%sevenzip% x %HOMEDRIVE%%HOMEPATH%\Downloads\4D_VL_win.zip -o%HOMEDRIVE%%HOMEPATH%\Documents\4DVL\
echo "BAT: 4D Volume Desktop unzipped"
