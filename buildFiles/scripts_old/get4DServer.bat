echo "BAT: Downloading 4D Server for Windows ..."
curl -s -u %BINARIES_USER%:%BINARIES_PASSWORD% -o %HOMEDRIVE%%HOMEPATH%\Downloads\4D_Server_win.zip %1%
echo "BAT: 4D Server  Windows downloaded, unzipping archive ..."
mkdir %HOMEDRIVE%%HOMEPATH%\Documents\4D_SERVER
%sevenzip% x %HOMEDRIVE%%HOMEPATH%\Downloads\4D_Server_win.zip -o%HOMEDRIVE%%HOMEPATH%\Documents\4D_SERVER\
echo "BAT: 4D Server unzipped"
