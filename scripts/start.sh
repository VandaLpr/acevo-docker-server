#!/bin/bash

echo "========================================"
echo "   AC EVO Docker Server"
echo "========================================"

export WINEPREFIX="/wine"
export WINEARCH="win64"

# Create required folders
mkdir -p /wine
mkdir -p /logs

# Install VC runtime (only once)
if [ ! -f "/wine/.vcrun_installed" ]; then
    echo "Installing VC runtime..."
    winetricks -q vcrun2019 || true
    touch /wine/.vcrun_installed
fi

cd $DATA_DIR

# Check server files
if [ ! -f "AssettoCorsaEVOServer.exe" ]; then
    echo "ERROR: Server files not found in $DATA_DIR"
    exit 1
fi

# Check args
if [ -z "$SERVER_ARGS" ]; then
    echo "ERROR: SERVER_ARGS not set!"
    exit 1
fi

echo "Starting server with args:"
echo "$SERVER_ARGS"

# Loop with logging
while true
do
    wine AssettoCorsaEVOServer.exe $SERVER_ARGS >> /logs/server.log 2>&1
    echo "Server crashed, restarting in 10s..."
    sleep 10
done
