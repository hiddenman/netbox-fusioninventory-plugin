# netbox-fusioninventory-plugin

This plugin can add devices from fusioninventory-agent or ocsinventory-agent.

```
fusioninventory-agent -s http://netbox.local/plugins/fusion-inventory/
```

### what working:

* Device creating/updating
* Serial Number (UUID)
* Asset Tag
* Components creating/updating
* Interfaces creating/updating
* IP addresses creating/updating
* Automatic tracking of everything
* History preserving of everything
* Full logging (Journal + Change Log)
* "Lazy" and "computed" variables

## Installation

First, add netbox-fusioninventory-plugin to your `/opt/netbox/local_requirements.txt` file. Create it if it doesn't exist.

Then enable the plugin in `/opt/netbox/netbox/netbox/configuration.py`, like:

```python

   PLUGINS = [
       'netbox_fusioninventory_plugin',
       ]
```

And finally run `/opt/netbox/upgrade.sh`. This will download and install the plugin and update the database when necessary. Don't forget to run sudo systemctl restart netbox netbox-rq like upgrade.sh tells you!

## configuration

You can overwrite fields with xml content or use internal objects.

```python
PLUGINS_CONFIG = {
        'netbox_fusioninventory_plugin':{
            "name":"xml:request.content.hardware.name",
            "device_role":"object:DeviceRole:unknown",
            "tenant":None,
            "manufacturer":"xml:request.content.bios.mmanufacturer",
            "device_type":"xml:request.content.bios.mmodel",
            "platform":"xml:request.content.hardware.osname",
            "serial":"xml:request.content.hardware.uuid",
            "asset_tag":"lazy:'WKS-'+device['serial']",
            "status":"str:active",
            "site":"object:Site:unknown",
            "location":None,
            "rack":None,
            "position":None,
            "face":None,
            "virtual_chassis":None,
            "vc_position":None,
            "vc_priority":None,
            "cluster":None,
            "comments":None,
        }
    }
```
