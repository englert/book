##############################################################
#######  AD <krisztian.czako@linuxakademia.com> alapján ######
##############################################################

FROM ubuntu:16.04
MAINTAINER Englert Ervin

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get tzdata \
 && rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Budapest /etc/localtime \
 && echo "Europe/Budapest" > /etc/timezone \
 && apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get -y install samba ldb-tools winbind krb5-user sssd \
 && apt-get clean \
 && rm -f /etc/samba/smb.conf \
 && rm -rf /var/lib/apt/lists/*
 
WORKDIR /root

COPY samba-ad-dc.sh /usr/local/bin/
COPY samba-provision.sh /usr/local/bin/

EXPOSE 636 445 1024 3268 3269 389 135 139 464 53 88 137 138
VOLUME ["/etc/samba", "/var/lib/samba", "/var/log/samba", "/var/cache/samba", "/home", "/srv/samba"]

CMD ["/usr/local/bin/samba-ad-dc.sh"]
