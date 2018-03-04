FROM alpine:3.7

# Update image and install base packages
RUN apk update && \
    apk upgrade && \
    apk add bash curl openjdk8 openssl && \
    rm -rf /var/cache/apk/*

ENV ELASTIC_VERSION=5.6.7
# Install elasticsearch user
WORKDIR /usr/share/elasticsearch

RUN curl -o elasticsearch-${ELASTIC_VERSION}.tar -sSL https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTIC_VERSION}.tar.gz && \
    tar -xzf elasticsearch-${ELASTIC_VERSION}.tar && \
    mv elasticsearch-${ELASTIC_VERSION} elasticsearch
RUN adduser -DH -s /sbin/nologin elasticsearch && \
    chown -R elasticsearch:0 elasticsearch

RUN mkdir /elasticsearch && \
    mkdir /elasticsearch/data && \
    mkdir /etc/elasticsearch && \
    chown -R elasticsearch:0 /elasticsearch && \
    cp /usr/share/elasticsearch/elasticsearch/config/log4j2.properties /etc/elasticsearch && \
    chown -R elasticsearch:0 /etc/elasticsearch && \
    chmod -R 775 /etc/elasticsearch && \
    chmod -R 775 /usr/share/elasticsearch/

USER elasticsearch
ENV PATH=$PATH:/usr/share
COPY entrypoint.sh /usr/share
COPY elasticsearch.yml /etc/elasticsearch/


EXPOSE 9200
EXPOSE 9300

ENTRYPOINT ["/usr/share/entrypoint.sh"]

CMD ["/usr/share/elasticsearch/elasticsearch/bin/elasticsearch", "-Epath.conf=/etc/elasticsearch"]
