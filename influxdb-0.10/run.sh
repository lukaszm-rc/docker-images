#!/bin/bash
export DB_PATH="/home/docker/influxdb"
docker run -v /data:"$DB_PATH" --net=host lukaszm/influxdb