FROM elasticsearch:7.16.2
WORKDIR /usr/share/elasticsearch
RUN echo y | ./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.16.2/elasticsearch-analysis-ik-7.16.2.zip
COPY . /usr/share/elasticsearch/config/analysis-ik