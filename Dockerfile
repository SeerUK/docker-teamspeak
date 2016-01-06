FROM ubuntu:trusty
MAINTAINER Elliot Wright <elliot@elliotwright.co>

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends ca-certificates curl && \
  apt-get clean && \
  rm -rf /var/lib/apt /tmp/* /var/tmp/* && \
  useradd -d /opt/ts3server -u 1000 -m -s /bin/bash ts3server && \
  mkdir -p /opt/ts3build && \
  mkdir -p /opt/ts3server && \
  curl -Ls http://dl.4players.de/ts/releases/3.0.11.4/teamspeak3-server_linux-amd64-3.0.11.4.tar.gz | tar zxf - -C /tmp && \
  cp -rf /tmp/teamspeak3-server_linux-amd64/* /opt/ts3build && \
  rm -rf /tmp/teamspeak3-server_linux-amd64

COPY ./provisioning/scripts/start.sh /opt/ts3build

RUN \
  chown -R ts3server: /opt/ts3build && \
  chown -R ts3server: /opt/ts3server && \
  chmod +x /opt/ts3build/start.sh

USER ts3server

EXPOSE 9987/udp
EXPOSE 10011
EXPOSE 30033

VOLUME [ "/opt/ts3server" ]

WORKDIR /opt/ts3server

CMD [ "/opt/ts3build/start.sh" ]
