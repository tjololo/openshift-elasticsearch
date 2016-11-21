FROM elasticsearch:2.4.1

MAINTAINER Vemund Gaukstad

ENV TZ=Europ/Oslo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER 1001
ENV PATH=$PATH:/usr/bin
COPY entrypoint.sh /usr/bin/
COPY elasticsearch.yml logging.yml /etc/elasticsearch/


EXPOSE 9200
EXPOSE 9300

RUN ls /usr/bin

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

CMD ["/usr/share/elasticsearch/bin/elasticsearch"]