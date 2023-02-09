#!/bin/bash
#
# Updates any observium install to the latest version while backing up for security.
# v0.4 - 09-02-2023
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
# Notes:
# Observium is very specific about permissions of individual files and folders, because of this, we not only make a backup file but also move the original folder
# so we can copy the pertinent folders and files after the update (which is esentially a reinstall aniway) mantaining the correct permisions. Not doing this causes
# polling to break and Observium needing a clean RRD and Logs folder to start polling again.
#######################
cd /opt
sudo tar cvf observium_pre_update_bkup_$date.tar.gz observium/
sudo mv observium observium_pre_update_$date
sudo wget -Oobservium-community-latest.tar.gz https://www.observium.org/observium-community-latest.tar.gz
sudo tar zxvf observium-community-latest.tar.gz
sudo cp -rp /opt/observium_pre_update_$date/rrd /opt/observium/
sudo cp -rp /opt/observium_pre_update_$date/logs /opt/observium/
sudo cp -p /opt/observium_pre_update_$date/config.php /opt/observium/
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
echo "All done. Remember to delete the backup folder once you've confirmed everything is ok but keep the backup tarball just in case."
echo
