FROM debian:jessie

ENV GOSU_REPO https://github.com/tianon/gosu/releases/download/1.7
ENV MONGO_VERSION 3.2

RUN groupadd -r mongodb && useradd -r -g mongodb mongodb
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl numactl mc
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "$GOSU_REPO/gosu-$(dpkg --print-architecture)" && \
    curl -o /usr/local/bin/gosu.asc -SL "$GOSU_REPO/gosu-$(dpkg --print-architecture).asc" && \
    gpg --verify /usr/local/bin/gosu.asc && rm /usr/local/bin/gosu.asc && \
    chmod +x /usr/local/bin/gosu

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/$MONGO_VERSION main" | tee /etc/apt/sources.list.d/mongodb-org-$MONGO_VERSION.list


RUN set -x && apt-get update && apt-get install -y \
	    mongodb-org && \
	rm -rf /var/lib/apt/lists/* && rm -rf /var/lib/mongodb && mv /etc/mongod.conf /etc/mongod.conf.orig

RUN mkdir -p /mnt/data/db && chown -R mongodb:mongodb /mnt/data/db && mkdir -p /mnt/var/run/mongodb && chown -R mongodb:mongodb /mnt/var/run/mongodb
#RUN curl -o /etc/mongod.conf "https://raw.githubusercontent.com/lukaszm-rc/dev-tools/docker@stable/docker/configs/mongod.conf"
COPY ./src/mongod.conf /etc/mongod.conf 
VOLUME /mnt
COPY ./src/mongo.sh /mongo.sh
ENTRYPOINT ["/mongo.sh"]
CMD ["mongod"]
