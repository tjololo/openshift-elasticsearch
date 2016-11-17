FROM elasticsearch:2.4.1

MAINTAINER Vemund Gaukstad

ENV TZ=Europ/Oslo \
    PATH=$PATH:/usr/bin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY entrypoint.sh /usr/bin/
COPY elasticsearch.yml logging.yml /etc/elasticsearch/


EXPOSE 9200
EXPOSE 9300
USER 1001

ENTRYPOINT ["entrypoint.sh"]

CMD ["/usr/share/elasticsearch/bin/elasticsearch"]