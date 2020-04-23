#!/bin/bash

Day=`date +%F`
LogPath=/var/log/openvpn


if [ -f ${LogPath}/${Day}.log ];then
    echo "`date '+%F %H:%M:%S'` User $common_name IP $trusted_ip is logged in" >> ${LogPath}/${Day}.log
else
    touch ${LogPath}/${Day}.log
    echo "`date '+%F %H:%M:%S'` User $common_name IP $trusted_ip is logged in" >> ${LogPath}/${Day}.log
fi
