#!/bin/bash

echo "========================================"
echo "   AC EVO Dedicated Server (Docker)"
echo "========================================"

# Init Wine samo prvi put
if [ ! -d "/wine/drive_c" ]; then
    echo "Initializing Wine..."
    xvfb-run wineboot
    sleep 5

    echo "Installing VC runtime..."
    winetricks -q vcrun2019
fi

cd /server

if [ -z "$SERVER_ARGS" ]; then
    echo "ERROR: SERVER_ARGS not set!"
    exit 1
fi

echo "Starting server with args:"
echo "$SERVER_ARGS"

while true
do
    xvfb-run wine AssettoCorsaEVOServer.exe $SERVER_ARGS
    echo "Server crashed, restarting in 10s..."
    sleep 10
done
