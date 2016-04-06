#!/bin/bash
set -e
echo "v1.27"
paths=(/mnt/data/db /tmp)
storageOptions="--directoryperdb --smallfiles --oplogSize 1073741824"
for dir in "$paths"
    do
    echo "Checking directory $dir"
    if [ ! -d "$dir" ]; then
        echo "Directory $dir not exists, creating"
        mkdir -p -v "$dir"
    fi
    echo "Changing directory permissions $dir"
    chown -v -R mongodb "$dir"
done

if [ "${1:0:1}" = '-' ]; then
    set -- mongod "$@"
else
    case "$1" in
    configsrv)  set -- mongod   --dbpath /mnt/data/db --configsvr --port=27019 --replSet "configReplSet"  ;;
    rs0)    set -- mongod  --dbpath /mnt/data/db --port=27017 --replSet "rs0" ${storageOptions} ;;
    shard0) set -- mongod  --dbpath /mnt/data/db --port=27018 --shardsvr --replSet=rs0 ${storageOptions} ;;
    shard1) set -- mongod  --dbpath /mnt/data/db --port=27020 --shardsvr --replSet=rs1 ${storageOptions} ;;
    mongos) set -- mongos  --configdb configReplSet/shard0.dev.lh:27019,shard1.dev.lh:27019,shard2.dev.lh:27019 ;;
    1337)   set -- mongod  --dbpath /mnt/data/db --port=1337 ${storageOptions} ;;
    standalone|default) set -- mongod  --dbpath /mnt/data/db --port=27017;;
    esac
fi

if [ "$1" = 'mongod' ]; then
	numa='numactl --interleave=all'
	if ${numa} true &> /dev/null; then
		set -- ${numa} "$@"
	fi

	exec gosu mongodb "$@"
fi

exec "$@"
