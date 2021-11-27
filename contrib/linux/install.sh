#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Installing packages"
# Install fusioninventory-agent and useful deps
pacman -S hdparm dmidecode pciutils fusioninventory-agent perl-parse-edid

echo "Disabling service and enabling systemd timer"
# disable fusioninventory-agent service because we will use systemd timer (like cron): daily at 11:00:00 and 5m after each boot
systemctl disable fusioninventory-agent && systemctl stop fusioninventory-agent.service

# add fusioninventory-agent service and its timer to run once per day
cp ./fusioninventory-agent.service ./fusioninventory-agent.timer /etc/systemd/system/
systemctl enable fusioninventory-agent.timer && systemctl start fusioninventory-agent.timer

systemctl status fusioninventory-agent.timer

echo "First run"
# run once
systemctl start fusioninventory-agent.service

