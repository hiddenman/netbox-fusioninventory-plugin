#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Downloading package"
curl  -O -J -k https://netbox.example.com/warehouse/fusioninventory/macos/FusionInventory-Agent-2.6-2.pkg.tar.gz
#curl  -O -J -k https://netbox.example.com/warehouse/fusioninventory/macos/org.fusioninventory.agent.plist

echo "Installing package"
# Install fusioninventory-agent
tar -xzf ./FusionInventory-Agent-2.6-2.pkg.tar.gz
installer -pkg ./FusionInventory-Agent-2.6-2.pkg -target /

echo "Disabling service and enabling launchd task"
# disable org.fusioninventory.agent service because we will use launchd task (like cron): every 86400 seconds
launchctl stop org.fusioninventory.agent
launchctl remove org.fusioninventory.agent

# add org.fusioninventory.agent.plist to the launchd
cp ./org.fusioninventory.agent.plist /Library/LaunchAgents/
chown root /Library/LaunchAgents/org.fusioninventory.agent.plist
launchctl load /Library/LaunchAgents/org.fusioninventory.agent.plist
launchctl list org.fusioninventory.agent

echo "First run"
# run once
/opt/fusioninventory-agent/bin/fusioninventory-agent -s https://netbox.example.com/plugins/fusion-inventory/ --no-ssl-check
