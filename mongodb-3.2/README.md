# Getting started
[![](https://badge.imagelayers.io/lukaszm/mongodb:latest.svg)](https://imagelayers.io/?images=lukaszm/mongodb:latest 'Get your own badge on imagelayers.io')

### Get image
```
docker pull lukaszm/mongodb
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
docker run --dit --net=host --name="mongo-1337" -v /some/dir:/mnt \
lukaszm/mongodb:latest 1337
```
#### Available presets
- **configsrv**		- for sharded cluster, runs on port *27019*
- **rs0**			- replicaSet named rs0, port *27017*
- **shard0**		- sharded replicaSet named rs0, port *27018*
- **shard1** 		- sharded replicaSet named rs1, port *27020*
- **mongos**		- **requires already configServers with hostname shard[0-3].dev.lh:27019**
- **1337**			- standalone server running on port *1337*


## Manual configuration
```
docker run <image-config> lukaszm/mongodb <mongo-config>
```
- *image-config* - docker related configuration (limits, networking, dns), see: https://docs.docker.com/engine/reference/run/
- *mongo-config* - mongo commandline parameters, see: https://docs.mongodb.org/manual/reference/program/mongod/
 
### Examples
Standalone server with auto-restart on failure (limited to 10 times)
```
docker run -dit --net="host" --name="mongodb" \
--restart=on-failure:10 -v "/some/path:/mnt" lukaszm/mongodb standalone
```

