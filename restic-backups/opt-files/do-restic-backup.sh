#!/bin/bash

BIN_INSTALL_PATH="/opt/restic-backup/bin"
RESTIC_BIN="$BIN_INSTALL_PATH/restic"

FULL_BACKUP_CMD="$RESTIC_BIN backup --exclude-file=backup-excludes.txt --exclude-caches /"
PRUNE_BACKUPS_CMD="$RESTIC_BIN forget --keep-last 4 --keep-daily 14 --keep-monthly 12 --keep-yearly 75"

source ./setup-restic-env.private.sh

# If I've never used this s3 bucket before:
# restic init

echo $PATH
if [ "$(whoami)" = "restic" ]; then
  eval "$FULL_BACKUP_CMD"
  eval "$PRUNE_BACKUPS_CMD"
else
  sudo -E -u restic $FULL_BACKUP_CMD
  sudo -E -u restic $PRUNE_BACKUPS_CMD
fi
