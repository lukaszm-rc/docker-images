FROM          ubuntu:latest
MAINTAINER    Lukasz Mazurek <lukasz.mazurek@redcart.pl>

ENV           DEBIAN_FRONTEND noninteractive

RUN           echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN           echo "deb http://ppa.launchpad.net/vbulax/collectd5/ubuntu precise main" >> /etc/apt/sources.list
RUN           apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 232E4010A519D8D831B81C56C1F5057D013B9839
RUN           apt-get -y update
RUN           apt-get -y install collectd curl

ADD           src/collectd.conf /etc/collectd/collectd.conf

ADD           start /usr/bin/start

RUN           chmod +x /usr/bin/start

CMD           start