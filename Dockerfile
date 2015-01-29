FROM ubuntu:14.04
MAINTAINER Martijn van Maurik <docker@vmaurik.nl>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

RUN apt-get update && apt-get dist-upgrade -yq

RUN apt-get -qy install nfs-kernel-server runit inotify-tools

RUN mkdir -p /exports

RUN mkdir -p /etc/sv/nfs
ADD nfs.init /etc/sv/nfs/run
ADD nfs.stop /etc/sv/nfs/finish

ADD start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

VOLUME /exports

EXPOSE 111/udp 2049/tcp

CMD ["/usr/local/bin/start.sh"]