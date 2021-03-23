clear
# Requirements & variable
bold=$(tput bold)
normal=$(tput sgr0)
echo ${bold}
echo "#####################################################"
echo "SNMP Installation & Configuration (For 18.04 onwards)"
echo "#####################################################"
echo ${normal}
echo
echo ${bold}What location would you like this system to show as being in?${normal}
read location1
echo
echo ${bold}What password should be used for SNMPD MD5 Connectivity?${normal}
read -s snmpdpw
echo
echo ${bold}What email address would you like this system to be linked to?${normal}
read -s email1
echo
sudo apt install snmpd -y
sudo cp /etc/snmp/snmpd.conf /etc/snmp/snmpd.config.org && sudo rm -rf /etc/snmp/snmpd.conf && sudo touch /etc/snmp/snmpd.conf
sudo bash -c "echo \#\#\#\#\#\#\# SNMPD Config \#\#\#\#\#\#\# >> /etc/snmp/snmpd.conf"
sudo bash -c "echo  >> /etc/snmp/snmpd.conf"
sudo bash -c "echo agentAddress udp:161,udp6:\[::1\]:161 >> /etc/snmp/snmpd.conf"
sudo bash -c "echo createUser authOnlyUser  MD5 '"'"'$snmpdpw'"'"' >> /etc/snmp/snmpd.conf"
sudo bash -c "echo view   systemonly  included   .1.3.6.1.2.1.1 >> /etc/snmp/snmpd.conf"
sudo bash -c "echo view   systemonly  included   .1.3.6.1.2.1.25.1 >> /etc/snmp/snmpd.conf"
sudo bash -c "echo rocommunity public  default    -V systemonly >> /etc/snmp/snmpd.conf"
sudo bash -c "echo rocommunity6 public  default   -V systemonly >> /etc/snmp/snmpd.conf"
sudo bash -c "echo rouser   authOnlyUser >> /etc/snmp/snmpd.conf"
sudo bash -c "echo sysLocation    $location1 >> /etc/snmp/snmpd.conf"
sudo bash -c "echo sysContact     $email1 >> /etc/snmp/snmpd.conf"
sudo bash -c "echo sysServices    72 >> /etc/snmp/snmpd.conf"
sudo bash -c "echo proc  mountd >> /etc/snmp/snmpd.conf"
sudo bash -c "echo proc  ntalkd    4 >> /etc/snmp/snmpd.conf"
sudo bash -c "echo proc  sendmail 10 1 >> /etc/snmp/snmpd.conf"
sudo bash -c "echo disk       /     10000 >> /etc/snmp/snmpd.conf"
sudo bash -c "echo disk       /var  5% >> /etc/snmp/snmpd.conf"
sudo bash -c "echo includeAllDisks  10% >> /etc/snmp/snmpd.conf"
sudo bash -c "echo load   12 10 5 >> /etc/snmp/snmpd.conf"
sudo bash -c "echo trapsink     localhost public >> /etc/snmp/snmpd.conf"
sudo bash -c "echo iquerySecName   internalUser >> /etc/snmp/snmpd.conf"
sudo bash -c "echo rouser          internalUser >> /etc/snmp/snmpd.conf"
sudo bash -c "echo defaultMonitors          yes >> /etc/snmp/snmpd.conf"
sudo bash -c "echo linkUpDownNotifications  yes >> /etc/snmp/snmpd.conf"
sudo bash -c "echo extend    test1   /bin/echo  Hello, world! >> /etc/snmp/snmpd.conf"
sudo bash -c "echo extend-sh test2   echo Hello, world! \; echo Hi there \; exit 35 >> /etc/snmp/snmpd.conf"
sudo bash -c "echo master          agentx >> /etc/snmp/snmpd.conf"
sudo service snmpd restart
clear
echo ${bold}Done. As far as the SNMP setup goes, you can now add this system to Observium. l${normal}
echo
