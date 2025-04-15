#!/bin/bash

INSTALL_DIR=/opt/restic-backup/scripts
SYSTEMD_DIR=/etc/systemd/system

sudo mkdir -p $INSTALL_DIR
sudo cp -r ./opt-files/* $INSTALL_DIR/

sudo cp -r ./systemd-files/* $SYSTEMD_DIR/
sudo systemctl daemon-reload
sudo systemctl enable --now restic-backup.timer

sudo systemctl daemon-reload
