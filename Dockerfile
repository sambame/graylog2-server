FROM charliek/openjdk-jre-7
MAINTAINER Shay Erlichmen "shay@samba.me"

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y pwgen libdigest-sha-perl

ENV GRAYLOG_HOME /opt/graylog2-server
ENV GRAYLOG_VER 0.92.0-SNAPSHOT-20141013094908

WORKDIR /opt/
RUN curl -L http://packages.graylog2.org/nightly-builds/graylog2-server-0.92.0-SNAPSHOT-20141013094908.tar.gz | tar zx



# server
RUN ln -sf /opt/graylog2-server-${GRAYLOG_VER} ${GRAYLOG_HOME}
RUN cp /opt/graylog2-server/graylog2.conf.example /etc/graylog2.conf

RUN java -Delasticsearch -Des.path.home="/opt" $properties -cp "$GRAYLOG_HOME/*" org.elasticsearch.plugins.PluginManager -install elasticsearch/elasticsearch-cloud-gce/2.3.0
RUN java -Delasticsearch -Des.path.home="/opt" $properties -cp "$GRAYLOG_HOME/*" org.elasticsearch.plugins.PluginManager -install elasticsearch/elasticsearch-cloud-aws/2.3.0

EXPOSE 12900

CMD  ["java", "-jar", "/opt/graylog2-server/graylog2-server.jar"]