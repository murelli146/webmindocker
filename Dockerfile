FROM alpine:latest
MAINTAINER Gernot Klobucaric <murelli146>
#ARG	webmin_version=1.962
ARG	webmin_version=1.973
COPY root / 
RUN apk update && \
	apk add --no-cache ca-certificates openssl perl perl-net-ssleay expect && \
	cd /etc/webmindocker && \
	wget "https://prdownloads.sourceforge.net/webadmin/webmin-$webmin_version-minimal.tar.gz" && \
	tar -zxvf webmin-$webmin_version-minimal.tar.gz && \
	ln -sf /etc/webmindocker/webmin-$webmin_version /etc/webmindocker/webmin
RUN mv /etc/webmindocker/setup.exp /etc/webmindocker/webmin/setup.exp && \
	cd /etc/webmindocker/webmin &&\
	/usr/bin/expect ./setup.exp && \
	rm setup.exp && \
	apk del expect && \
	/etc/webmindocker/webmin/install-module.pl /etc/webmindocker/cron.wbm.gz && \
	/etc/webmindocker/webmin/install-module.pl /etc/webmindocker/webmincron.wbm.gz && \
	/etc/webmindocker/webmin/install-module.pl /etc/webmindocker/sshd.wbm.gz && \
	/etc/webmindocker/webmin/install-module.pl /etc/webmindocker/mailboxes.wbm.gz && \
	/etc/webmindocker/webmin/install-module.pl /etc/webmindocker/mount.wbm.gz && \
	/etc/webmindocker/webmin/install-module.pl /etc/webmindocker/fsdump.wbm.gz && \
	cd /etc/webmindocker && \
	rm *.gz && \
	apk --update add tar
RUN apk --update add --no-cache openssh bash \
	&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
	&& echo "root:root" | chpasswd \
	&& rm -rf /var/cache/apk/*
RUN sed -ie 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
RUN sed -ri 's/#HostKey \/etc\/ssh\/ssh_host_key/HostKey \/etc\/ssh\/ssh_host_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_rsa_key/HostKey \/etc\/ssh\/ssh_host_rsa_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_dsa_key/HostKey \/etc\/ssh\/ssh_host_dsa_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ecdsa_key/HostKey \/etc\/ssh\/ssh_host_ecdsa_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ed25519_key/HostKey \/etc\/ssh\/ssh_host_ed25519_key/g' /etc/ssh/sshd_config
RUN /usr/bin/ssh-keygen -A
RUN ssh-keygen -t rsa -b 4096 -f  /etc/ssh/ssh_host_key

#Cron:
RUN apk update && apk add dcron curl wget rsync ca-certificates && rm -rf /var/cache/apk/*
RUN mkdir -p /var/log/cron && mkdir -m 0644 -p /var/spool/cron/crontabs && touch /var/log/cron/cron.log && mkdir -m 0644 -p /etc/cron.d

VOLUME	["/etc/webmin" , "/var/webmin" , "/var/spool/cron/crontabs"]
EXPOSE 22
EXPOSE 10000
CMD ["/etc/webmindocker/run.sh"]
