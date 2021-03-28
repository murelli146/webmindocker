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
sh /docker-cmd.sh tail
#webmin
/usr/sbin/sshd
/etc/webmin/start --nofork
