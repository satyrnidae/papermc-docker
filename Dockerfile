# JRE base
FROM openjdk:17-slim

#centos
FROM centos:7.8.2003
ENV DOCKER_VERSION='19.03.8'
RUN set -ex \
    && DOCKER_FILENAME=https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz \
    && curl -L ${DOCKER_FILENAME} | tar -C /usr/bin/ -xzf - --strip-components 1 docker/docker

# Environment variables
ENV MC_VERSION="latest" \
    PAPER_BUILD="latest" \
    MC_RAM="" \
    JAVA_OPTS=""

COPY papermc.sh .
RUN apt-get update \
    && apt-get install -y wget \
    && apt-get install -y jq \
    && apt-get install -y sudo \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /papermc

RUN groupadd -g 6969 papermc && \
    useradd -r -u 6969 -g papermc papermc

# Start script
CMD ["sh", "/papermc.sh"]

# Container setup
EXPOSE 25565/tcp
EXPOSE 25565/udp
VOLUME /papermc
