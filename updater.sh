#!/bin/bash
#
# Updates any observium install to the latest version while backing up for security.
# v0.2 - 27-06-2022
# dev: @Altersoundwork
#
clear
#######################
echo ${bold}
echo "################"
echo "Observium Update"
echo "################"
echo ${normal}
#######################
cd /opt
sudo tar cvf observium_pre_update_$date.tar.gz observium/
sudo mv observium observium_pre_update_$date
sudo wget -Oobservium-community-latest.tar.gz https://www.observium.org/observium-community-latest.tar.gz
sudo tar zxvf observium-community-latest.tar.gz
sudo cp -r /opt/observium_pre_update_$date/rrd /opt/observium/
sudo cp -r /opt/observium_pre_update_$date/logs /opt/observium/
sudo chown -R www-data:www-data /opt/observium/rrd && sudo chown -R www-data:www-data /opt/observium/logs && sudo chmod -R 777 /opt/observium/rrd
sudo cp /opt/observium_pre_update_$date/config.php /opt/observium/
echo
read -p "${bold}If you see no errors, we're now ready to perform the update. Do you wish to continue?${normal}" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && echo && echo exit 1 || return 1
fi
clear
sudo /opt/observium/discovery.php -u
echo
read -p "${bold}All done. If it has been a very long time since you've updated (12 months or more), you may want to force an immediate rediscovery of all devices to make sure things are up to date. Do you wish to continue?${normal}" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && echo && echo exit 1 || return 1
fi
/opt/observium/discovery.php -h all && /opt/observium/poller.php -h all
sudo rm observium-community-latest.tar.gz
echo
