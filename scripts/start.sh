#!/bin/bash

echo "========================================"
echo "   AC EVO Docker Server                 "
echo "========================================"

export WINEPREFIX="/wine"
export WINEARCH="win64"

cd $DATA_DIR

# Provjera servera
if [ ! -f "AssettoCorsaEVOServer.exe" ]; then
    echo "ERROR: Server files not found in $DATA_DIR"
    echo "Please mount your server files!"
    exit 1
fi

# Ako nema args
if [ -z "$SERVER_ARGS" ]; then
    echo "ERROR: SERVER_ARGS not set!"
    exit 1
fi

echo "Starting server with args:"
echo "$SERVER_ARGS"

# Loop (auto restart)
while true
do
    wine AssettoCorsaEVOServer.exe $SERVER_ARGS
    echo "Server crashed, restarting in 10s..."
    sleep 10
done
