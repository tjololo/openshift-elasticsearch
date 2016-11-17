FROM elasticsearch:2.4.1

MAINTAINER Vemund Gaukstad

ENV TZ=Europ/Oslo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER 1001

COPY entrypoint.sh /usr/bin/
COPY elasticsearch.yml logging.yml /etc/elasticsearch/


EXPOSE 9200
EXPOSE 9300

ENTRYPOINT ["entrypoint.sh"]

CMD ["/usr/share/elasticsearch/bin/elasticsearch"]