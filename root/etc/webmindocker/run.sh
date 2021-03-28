#!/bin/bash
#########################################################
#	webmindocker                                        #
#		Date		: 12.12.2020                        #
#		Version		: 1.00                              #
#		Autor		: (c)2020 Gernot Klobucaric         #
#		Kontakt		: forum.timberwolf.io               #
#		Member		: murelli146                        #
#########################################################

#Cron
sh /docker-entry.sh
echo "Start cron"
sh /docker-cmd.sh tail &
echo "Start webmin"
#webmin
echo "Start sshd"
/usr/sbin/sshd
echo "Start webmin"
/etc/webmin/start --nofork
