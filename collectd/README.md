# Getting started
[![](https://badge.imagelayers.io/lukaszm/collectd:latest.svg)](https://imagelayers.io/?images=lukaszm/collectd:latest 'Get your own badge on imagelayers.io')

### Get image
```
docker pull lukaszm/collectd
```

# Running container
```
docker run \
-d \
-v /var/run/docker.sock:/var/run/docker.sock \
--net=host \
-e INFLUXDB_HOST=$CLUSTER_INFLUXDB \
-e INFLUXDB_PORT=$CLUSTER_INFLUXDB_PORT \
-e COLLECTD_HOST=$HOSTNAME \
--restart=on-failure:10 \
--name="collectd" \
lukaszm/collectd:collectd
```