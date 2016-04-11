# Getting started
[![](https://badge.imagelayers.io/lukaszm/colelctd:latest.svg)](https://imagelayers.io/?images=lukaszm/collectd:latest 'Get your own badge on imagelayers.io')

### Get image
```
docker pull lukaszm/collectd
```

# Starting
You have 2 choices - configure instance by yourself, or use one
of the presets. In both cases If You wants to access data outside the container, then
You have to mount volumes.
- /mnt	- pass `-v /path/on.host:/mnt` with docker run

## Using presets
This preset will run single standalone mongodb instance on port **1337** (to avoid port conflicts if You want to test sharding or replicaset on same machine)

#### Example
```
docker run -dit --net=host --restart=on-failure:10  --name="collectd" lukaszm/collectd:latest
```
