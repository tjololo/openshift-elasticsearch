FROM elasticsearch:2.4.1

MAINTAINER Vemund Gaukstad

ENV TZ=Europ/Oslo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && useradd -G elasticsearch 1001

USER 1001
ENV PATH=$PATH:/usr/share
COPY entrypoint.sh /usr/share
COPY elasticsearch.yml logging.yml /etc/elasticsearch/


EXPOSE 9200
EXPOSE 9300

ENTRYPOINT ["/usr/share/entrypoint.sh"]

CMD ["/usr/share/elasticsearch/bin/elasticsearch"]