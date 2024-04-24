rem download 4D, leave it in Documents\4D folder


echo "BAT: Downloading 4D for Windows ..."
curl -s -u %BINARIES_USER%:%BINARIES_PASSWORD% -o %HOMEDRIVE%%HOMEPATH%\Downloads\4D.zip %1%
echo "BAT: 4D Windows downloaded, unzipping archive ..."
mkdir %HOMEDRIVE%%HOMEPATH%\Documents\4D
%sevenzip% x %HOMEDRIVE%%HOMEPATH%\Downloads\4D.zip -o%HOMEDRIVE%%HOMEPATH%\Documents\4D\
echo "BAT: 4D unzipped"
