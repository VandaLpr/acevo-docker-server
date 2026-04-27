#!/bin/bash

echo "========================================"
echo "Assetto Corsa EVO Server - Setup Required"
echo "========================================"

export WINEPREFIX="/wine"
export WINEARCH="win64"

DATA_DIR="/config/server"
LOG_DIR="/config/logs"
LOG_FILE="$LOG_DIR/server.log"

mkdir -p "$DATA_DIR"
mkdir -p "$LOG_DIR"
mkdir -p /wine

cd "$DATA_DIR"

# Check server files
if [ ! -f "AssettoCorsaEVOServer.exe" ]; then
    echo "❌ Server files not found!"
    echo ""
    echo "➡️ Install via Steam:"
    echo "   Tools → Assetto Corsa EVO Dedicated Server"
    echo ""
    echo "➡️ Copy ALL files into:"
    echo "   /config/server"
    echo ""
    sleep infinity
fi

# Load args (file ima prioritet)
if [ -f /config/server_args.txt ]; then
    echo "Using args from /config/server_args.txt"
    SERVER_ARGS="$(cat /config/server_args.txt)"
fi

# Check SERVER_ARGS
if [ -z "$SERVER_ARGS" ]; then
    echo "❌ SERVER_ARGS not set!"
    echo "➡️ Copy command from launcher into:"
    echo "   /config/server_args.txt"
    sleep infinity
fi

echo "Starting server with args:"
echo "$SERVER_ARGS"

# Start server loop
while true
do
    wine AssettoCorsaEVOServer.exe $SERVER_ARGS 2>&1 | tee -a "$LOG_FILE"
    echo "⚠️ Server stopped/crashed, restarting in 10s..."
    sleep 10
done
