# This is based on itzg/minecraft-server

FROM java:8 

MAINTAINER Jayson Reis <santosdosreis@gmail.com>

RUN apt-get update && apt-get install -y wget unzip
RUN addgroup --gid 1234 minecraft
RUN adduser --disabled-password --home=/data --uid 1234 --gid 1234 --gecos "minecraft user" minecraft

RUN mkdir -p /tmp/feed-the-beast/libraries/net/minecraft/launchwrapper/1.11 && cd /tmp/feed-the-beast && \
	wget -c http://ftb.cursecdn.com/FTB2/modpacks/FTBInfinity/2_2_2/FTBInfinityServer.zip && \
	unzip FTBInfinityServer.zip && \
	rm FTBInfinityServer.zip && \
	bash -x FTBInstall.sh && \
	chown -R minecraft /tmp/feed-the-beast


USER minecraft

EXPOSE 25565

ADD start.sh /start

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

CMD /start

ENV MOTD A Minecraft (FTB Infinity 2.2.2) Server Powered by Docker
ENV LEVEL world
ENV JVM_OPTS -Xms2048m -Xmx2048m
