FROM ubuntu:trusty
MAINTAINER Elliot Wright <elliot@elliotwright.co>

#Create Shared volume for Teamspeak Server Files
VOLUME ["/data/teamspeak"]

# Add repositories and update base
RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends ca-certificates curl && \
  apt-get clean && \
  rm -rf /var/lib/apt /tmp/* /var/tmp/* && \
  useradd -d /opt/teamspeak -u 1000 -m -s /bin/bash teamspeak && \
  curl -Ls http://dl.4players.de/ts/releases/3.0.11.4/teamspeak3-server_linux-amd64-3.0.11.4.tar.gz | tar zxf - -C /tmp && \
  cp -r /tmp/teamspeak3-server_linux-amd64/* /opt/teamspeak && \
  rm -rf /tmp/teamspeak3-server_linux-amd64

COPY ./provisioning/scripts/start.sh /opt/teamspeak

RUN \
  chown -R teamspeak: /opt/teamspeak && \
  chown -R teamspeak: /data && \
  chmod +x /opt/teamspeak/start.sh

USER teamspeak

EXPOSE 9987/udp
EXPOSE 10011
EXPOSE 30033

VOLUME [ "/data/teamspeak" ]

WORKDIR /opt/teamspeak

CMD [ "/opt/teamspeak/start.sh" ]
