#!/bin/sh

set -e

if [ -n "${MESOS_HOST}" ]; then
  if [ -z "${COLLECTD_HOST}" ]; then
    export COLLECTD_HOST="${MESOS_HOST}"
  fi
fi

export COLLECTD_INTERVAL=${COLLECTD_INTERVAL:-10}

# Adding a user if needed to be able to communicate with docker
GROUP=docker
if [ -e /var/run/docker.sock ]; then
    if [ ! -e "/var/run/group_created" ]; then
	GROUP_ID=$(ls -ln /var/run/docker.sock | awk '{ print $4 }')
	groupadd -f -g "${GROUP_ID}" "${GROUP}"
	touch /var/run/group_created
    fi
    if [ ! -e "/var/run/user_created" ]; then
	useradd -g "${GROUP}" collectd-docker-collector
	touch /var/run/user_created
    fi
fi
exec reefer -t /etc/collectd/collectd.conf.tpl:/tmp/collectd.conf \
  collectd -f -C /tmp/collectd.conf "$@"
