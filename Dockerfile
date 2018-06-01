FROM openjdk:8-jre-alpine

ARG TINKERPOP_VERSION=3.3.3
ARG TINKERPOP_DIR=/opt/apache-tinkerpop-gremlin-server-${TINKERPOP_VERSION}
ARG TINKERPOP_URL=https://www.apache.org/dyn/closer.cgi?action=download&filename=tinkerpop/${TINKERPOP_VERSION}/apache-tinkerpop-gremlin-server-${TINKERPOP_VERSION}-bin.zip

ENV TINKERPOP_VERSION ${TINKERPOP_VERSION}

RUN \
  /sbin/apk add --update bash perl wget                && \
  /usr/sbin/addgroup -S gremlin                        && \
  /usr/sbin/adduser \
       -D -H -S \
       -G gremlin \
       -g gremlin \
       -h /home/gremlin \
       -s /bin/bash \
       gremlin

RUN \
  /bin/mkdir -p /opt                                   && \
  cd /opt                                              && \
  /usr/bin/wget -O gremlin-server.zip ${TINKERPOP_URL} && \
  /usr/bin/unzip gremlin-server.zip                    && \
  /bin/rm -f gremlin-server.zip                        && \
  /bin/ln -s ${TINKERPOP_DIR} /opt/gremlin-server      && \
  cd /opt/gremlin-server                               && \
  bin/gremlin-server.sh install org.apache.tinkerpop gremlin-python ${TINKERPOP_VERSION}

RUN \
  /bin/chown -Rc gremlin:gremlin ${TINKERPOP_DIR}

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 8182/tcp
USER gremlin:gremlin
WORKDIR /opt/gremlin-server
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["conf/gremlin-server.yaml"]
