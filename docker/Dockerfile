FROM elasticsearch:2.4.1

MAINTAINER Vemund Gaukstad

ENV TZ=Europ/Oslo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER 1001
ENV PATH=$PATH:/usr/share
COPY entrypoint.sh /usr/share
COPY elasticsearch.yml logging.yml /opt/app-root/elasticsearch/


EXPOSE 9200
EXPOSE 9300

ENTRYPOINT ["/usr/share/entrypoint.sh"]

CMD ["/usr/share/elasticsearch/bin/elasticsearch"]