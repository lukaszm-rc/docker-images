FROM          debian:jessie
MAINTAINER    Lukasz Mazurek <lukasz.mazurek@redcart.pl>

COPY src/ /go/src/github.com/bobrik/collectd-docker

RUN /go/src/github.com/bobrik/collectd-docker/docker/build.sh

ENTRYPOINT ["/run.sh"]
