#++++++++++++++++++++++++++++++++++++++
# Elasticsearch Docker container
#++++++++++++++++++++++++++++++++++++++

# FROM elasticsearch
FROM docker.elastic.co/elasticsearch/elasticsearch:5.6.6

# RUN echo "node.max_local_storage_nodes: 1" > /usr/share/elasticsearch/config/elasticsearch.yml
COPY ./conf/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

