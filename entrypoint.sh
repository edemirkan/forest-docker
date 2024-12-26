#!/usr/bin/env sh

# Script variables
GAME_DIR="$(pwd)"
GAME_BIN="TheForestDedicatedServer.exe"
GAME_CFG="$GAME_DIR/config/server.cfg"
GAME_ARGS="-batchmode -dedicated -savefolderpath ${GAME_DIR}/saves/ -configfilepath ${GAME_CFG}"

# Check if required files exist
if [ ! -f "$GAME_BIN" ]; then
    echo "Error: Game binary not found: $GAME_BIN"
    exit 1
fi

if [ ! -f "$GAME_CFG" ]; then
    echo "Error: Server configuration file not found: $GAME_CFG"
    exit 1
fi

# Start the game server
xvfb-run --auto-servernum --server-args="-screen 0 640x480x24:32" wine $GAME_BIN $GAME_ARGS
