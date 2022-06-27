# Observium-Tools
Scripts to aid in Observium day to day tasks

Remember to set the IPs and aliases in your system's host file (as Observium uses the hostname as the system name and so using just IPs would make it hard to identify the system).

When adding a Linux system to Observium (after running one of the SNMP setup scripts).

* Hostname should be exactly the same as specified in the hosts file.
* Skip PING should be disabled.
* Protocol should be V3
* Transport should be UDP.
* Port should be 161
* Timeout should be 1
* Retries should be 5
* Ignore existing RRDs should be enabled.
* Auth Level should be authNoPriv
* Auth Username should be authOnlyUser
* Auth Password should be the one set in the previous script.
* Auth Algorithm should be MD5
* Click Add device.

For Windows, follow the steps in the Windows file.
