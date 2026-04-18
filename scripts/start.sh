#!/bin/bash

echo "========================================"
echo "   AC EVO Docker Server"
echo "========================================"

export WINEPREFIX="/wine"
export WINEARCH="win64"

# Create wine prefix if needed
mkdir -p /wine

cd $DATA_DIR

# Check server files
if [ ! -f "AssettoCorsaEVOServer.exe" ]; then
    echo "ERROR: Server files not found in $DATA_DIR"
    exit 1
fi

# Check SERVER_ARGS
if [ -z "$SERVER_ARGS" ]; then
    echo "ERROR: SERVER_ARGS not set!"
    exit 1
fi

echo "Starting server with args:"
echo "$SERVER_ARGS"

# Start server loop
while true
do
    wine AssettoCorsaEVOServer.exe $SERVER_ARGS >> /logs/server.log 2>&1
    echo "Server stopped/crashed, restarting in 10s..."
    sleep 10
done
