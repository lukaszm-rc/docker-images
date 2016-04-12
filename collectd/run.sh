#!/bin/bash
DB_PATH="/home/docker/influxdb"
INFLUXDB_HOST='localhost'
INFLUXDB_COLLECTD_PORT='25826'
COLLECTD_INTERVAL='5'


docker run \
-d \
-v /var/run/docker.sock:/var/run/docker.sock \
--net=host \
-e INFLUXDB_HOST="$INFLUXDB_HOST" \
-e INFLUXDB_COLLECTD_PORT="$INFLUXDB_COLLECTD_PORT" \
-e COLLECTD_HOST="$HOSTNAME" \
--restart=on-failure:10 \
--name="collectd" \
lukaszm/collectd:latest