*ATTENTION!* This guide assumes that this Windows PC, Server or Instance is already part of the your VLAN and that its VLAN IP is added to the Observium Instance's Host file.

Normally neither Windows Server nor Windows 7/8/10 come with the SNMP service installed. To check, open a Powershell interface as administrator and run the following command:

Get-Service -Name snmp*

If only SNMP Trap comes up, you'll need to install the SNMP service. To do so, run the following command:

Install-WindowsFeature SNMP-Service -IncludeManagementTools

For Windows 10 1803 onward, use the following (as the previous command will fail).

Add-WindowsCapability -Online -Name "SNMP.Client~~~~0.0.1.0"

Once done, close Powershell. Click on Start, type in “services.msc” and press enter. Scroll down to and double click “SNMP Service”.

* Select the “*Agent*” tab.
* Add “your@email.com” in the Contact field.
* Under location, choose accordingly.
* Only enable “Physical” and “Applications”, uncheck all other boxes.
* Select the “*Security*” tab.
* Enable the “Send authentication trap” checkbox.
* Under “Accepted community names”, click “Add”. Community rights should be READ CREATE and the Community Name you want (keep it simple). Click Add.
* Select “Accept SNMP packets from these hosts” and Add the is Observium's VLAN ip.
* Click on “*Apply*” and “*OK*”.
* Right click on the SNMP Service and select Restart.

In Observium, select “Devices” followed by “Add Device”.

* Hostname should be exactly the same as specified in the hosts file.
* Skip PING should be disabled.
* Protocol should be V2c
* Transport should be UDP.
* Port should be 161
* Timeout should be 1
* Retries should be 5
* Ignore existing RRDs should be enabled.
* SNMP Community should be the one you specified in Windows.
* Click Add device.
