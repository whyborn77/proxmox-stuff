sudo mkdir -p /zfs-mm-data/pvehost-backup && \
sudo chmod 755 /zfs-mm-data/pvehost-backup && \
sudo bash -c 'cat > /etc/cron.daily/pvehost-backup << EOF
#!/bin/sh
BACKUP_PATH="/zfs-mm-data/pvehost-backup/"
BACKUP_FILE="\$(hostname)_backup"
KEEP_DAYS=7
PVE_BACKUP_SET="/etc/pve/ /etc/lvm/ /etc/modprobe.d/ /etc/network/interfaces /etc/vzdump.conf /etc/sysctl.conf /etc/resolv.conf /etc/ksmtuned.conf /etc/hosts /etc/hostname /etc/cron* /etc/aliases"
PVE_CUSTOM_BACKUP_SET="/etc/fstab /etc/multipath.conf /etc/modules-load.d/modules.conf /etc/apt/sources.list.d/pve-enterprise.list"

tar -czf "\$BACKUP_PATH\$BACKUP_FILE-\$(date +%Y_%m_%d-%H_%M).tar.gz" --absolute-names \$PVE_BACKUP_SET \$PVE_CUSTOM_BACKUP_SET
find "\$BACKUP_PATH" -name "\$BACKUP_FILE-*" -type f -mtime +\$KEEP_DAYS -delete
EOF' && \
sudo chmod +x /etc/cron.daily/pvehost-backup
