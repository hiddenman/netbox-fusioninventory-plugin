=============================
netbox-fusioninventory-plugin
=============================

This plugin can add devices from fusioninventory-agent or ocsinventory-agent.

.. code-block::console

   $ fusioninventory-agent -s http://netbox.local/plugins/fusion-inventory/

what working:

* add device name
* Device Type
* Serial Number
* Asset Tag

todo 

* add components
* add config
* add interfaces
* add ip

Installation
------------

First, add netbox-fusioninventory-plugin to your /opt/netbox/local_requirements.txt file. Create it if it doesn't exist.

Then enable the plugin in /opt/netbox/netbox/netbox/configuration.py, like:

.. code-block::python

   PLUGINS = [
       'netbox_fusioninventory_plugin',
       ]


And finally run /opt/netbox/upgrade.sh. This will download and install the plugin and update the database when necessary. Don't forget to run sudo systemctl restart netbox netbox-rq like upgrade.sh tells you!
