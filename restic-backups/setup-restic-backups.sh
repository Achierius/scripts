#!/bin/bash

# TODO take the version as a parameter
read -r -p "Have you updated A) setup-restic-env.private.sh, and B) the restic version in the curl command herein? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        echo "Continuing..."
        ;;
    *)
        exit 1
        ;;
esac

# TODO be smarter than just repeatedly calling sudo

# TODO de-dupe this def with update-restic-install.sh's INSTALL_DIR
sudo mkdir -p /opt/restic-backup/bin
sudo bash -c 'curl -L https://github.com/restic/restic/releases/download/v0.12.1/restic_0.12.1_linux_amd64.bz2 | bunzip2 > /opt/restic-backup/bin/restic'
sudo chown root:restic /opt/restic-backup/bin/restic
sudo chmod 750 /opt/restic-backup/bin/restic
sudo setcap cap_dac_read_search=+ep /home/restic/restic/bin/restic

# TODO this is not the right way to do this
sudo mkdir -p /opt/restic-backup/lock
sudo chmod 1777 /opt/restic-backup/lock

sudo useradd --system --create-home --shell /sbin/nologin restic

source ./update-system-configuration.sh
sudo systemctl enable --now restic-backup.timer
