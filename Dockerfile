# This is based on itzg/minecraft-server

FROM java:8

MAINTAINER Jayson Reis <santosdosreis@gmail.com>

RUN apt-get update && apt-get install -y wget unzip
RUN addgroup --gid 1234 minecraft
RUN adduser --disabled-password --home=/data --uid 1234 --gid 1234 --gecos "minecraft user" minecraft

RUN mkdir /tmp/feed-the-beast && cd /tmp/feed-the-beast && \
	wget -c http://addons-origin.cursecdn.com/files/2293/83/FTBInfinityEvlovedSkyblockServer_1.2.0.zip && \
	unzip FTBInfinityEvlovedSkyblockServer_1.2.0.zip && \
	rm FTBInfinityEvlovedSkyblockServer_1.2.0.zip && \
	bash -x FTBInstall.sh && \
	chown -R minecraft /tmp/feed-the-beast

USER minecraft

EXPOSE 25565

ADD start.sh /start

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

CMD /start

ENV MOTD A Minecraft (FTB Infinity Evolved Skyblock 1.1.0) Server Powered by Docker
ENV LEVEL world
ENV JVM_OPTS -Xms2048m -Xmx2048m
