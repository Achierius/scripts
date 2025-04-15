#!/bin/bash

BIN_INSTALL_PATH="/opt/restic-backup/bin"
RESTIC_BIN="$BIN_INSTALL_PATH/restic"

PRUNE_BACKUPS_CMD="$RESTIC_BIN forget --keep-last 4 --keep-daily 14 --keep-monthly 12 --keep-yearly 101"

source ./setup-restic-env.private.sh

echo $PATH
if [ "$(whoami)" = "restic" ]; then
  eval "$PRUNE_BACKUPS_CMD"
else
  sudo -E -u restic $PRUNE_BACKUPS_CMD
fi
