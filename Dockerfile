FROM centos:centos7

MAINTAINER m4d3bug
     
ADD entrypoint /

EXPOSE 53/udp 53/tcp

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 \
    && yum update -y \
    && yum install -y bind-utils bind bind-chroot \
    && yum clean all \
    && rm -rf /usr/local/src/* \
    && touch /var/named/bind.log \
    && chown named:named -R /var/named/bind.log \
    && rndc-confgen -a -c /etc/rndc.key \
    && chown named:named /etc/rndc.key \
    && chmod 755 /entrypoint

ENTRYPOINT [ "/entrypoint" ]

CMD [ "/usr/sbin/init" ]



