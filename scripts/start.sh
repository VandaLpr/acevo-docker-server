#!/bin/bash

echo "========================================"
echo "   AC EVO Docker Server"
echo "========================================"

export WINEPREFIX="/wine"
export WINEARCH="win64"

# Create required folders
mkdir -p /wine
mkdir -p /logs

cd $DATA_DIR

# Check server files
if [ ! -f "AssettoCorsaEVOServer.exe" ]; then
    echo "ERROR: Server files not found in $DATA_DIR"
    exit 1
fi

# Check args file
if [ ! -f "/acevo/args.txt" ]; then
    echo "ERROR: args.txt not found in /acevo"
    exit 1
fi

# Load args
ARGS=$(cat /acevo/args.txt)

echo "Starting server with args:"
echo "$ARGS"

# Start server (with logging)
while true
do
    wine AssettoCorsaEVOServer.exe $ARGS | tee -a /logs/server.log
    echo "Server crashed, restarting in 10s..."
    sleep 10
done
