#!/bin/bash
DB_PATH="/home/docker/influxdb"
CLUSTER_INFLUXDB_HOST='localhost'
CLUSTER_INFLUXDB_PORT='25826'
COLLECTD_INTERVAL='5'


docker run \
-d \
-v /var/run/docker.sock:/var/run/docker.sock \
--net=host \
-e INFLUXDB_HOST="$(CLUSTER_INFLUXDB)" \
-e INFLUXDB_PORT="$(CLUSTER_INFLUXDB_PORT)" \
-e COLLECTD_HOST="$(HOSTNAME)" \
--restart=on-failure:10 \
--name="collectd" \
lukaszm/collectd:dev