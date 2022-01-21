#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Downloading package"
curl  -O -J -k https://netbox.company.com/warehouse/fusioninventory/macos/FusionInventory-Agent-2.6-2.pkg.tar.gz
curl  -O -J -k https://netbox.company.com/warehouse/fusioninventory/macos/org.fusioninventory.agent.company.plist

echo "Installing package"
# Install fusioninventory-agent
tar -xzf ./FusionInventory-Agent-2.6-2.pkg.tar.gz
installer -pkg ./FusionInventory-Agent-2.6-2.pkg -target /

echo "Disabling service and enabling launchd task"
# disable org.fusioninventory.agent service because we will use launchd task (like cron): every 86400 seconds
launchctl stop -w org.fusioninventory.agent
launchctl remove -w org.fusioninventory.agent

launchctl unload -w /Library/LaunchAgents/org.fusioninventory.agent.plist
launchctl unload -w /Library/LaunchDaemons/org.fusioninventory.agent.plist
launchctl unload -w /Library/LaunchDaemons/org.fusioninventory.agent.company.plist
rm /Library/LaunchAgents/org.fusioninventory.agent.plist
rm /Library/LaunchDaemons/org.fusioninventory.agent.company.plist

# add org.fusioninventory.agent.plist to the launchd
cp ./org.fusioninventory.agent.company.plist /Library/LaunchDaemons/
chown root /Library/LaunchDaemons/org.fusioninventory.agent.company.plist
launchctl load -w /Library/LaunchDaemons/org.fusioninventory.agent.company.plist
launchctl list org.fusioninventory.agent.company

#echo "First run"
# run once
#/opt/fusioninventory-agent/bin/fusioninventory-agent -s https://netbox.company.com/plugins/fusion-inventory/ --no-ssl-check

