FROM charliek/openjdk-jre-7
MAINTAINER Shay Erlichmen "shay@samba.me"

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y pwgen libdigest-sha-perl

WORKDIR /opt/
RUN curl -L http://packages.graylog2.org/releases/graylog2-server/graylog2-server-0.91.0-rc.1.tgz | tar zx

# server
RUN ln -sf /opt/graylog2-server-0.91.0-rc.1 /opt/graylog2-server
RUN cp /opt/graylog2-server/graylog2.conf.example /etc/graylog2.conf

EXPOSE 12900
VOLUME ['/etc']

ENTRYPOINT  ["java", "-jar", "/opt/graylog2-server/graylog2-server.jar"]
