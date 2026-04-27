#!/bin/bash
set -e

mkdir -p /config/logs

LOG_FILE="/config/logs/server.log"

if [ -f /app/start.sh ]; then
  START_CMD="/app/start.sh"
else
  START_CMD="/app/server"
fi

ARGS=""

if [ -f /config/server_args.txt ]; then
  echo "Using args from file"
  ARGS="$(cat /config/server_args.txt)"
else
  ARGS="$SERVER_ARGS"
fi

if [ -z "$ARGS" ]; then
  echo "No args provided. Waiting..."
  sleep infinity
fi

echo "Starting with args:"
echo "$ARGS"

exec $START_CMD $ARGS 2>&1 | tee -a "$LOG_FILE"
