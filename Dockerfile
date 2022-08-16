# Use the official image as a parent image.
FROM python:3.8.5-slim-buster

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git supervisor pkg-config python-numpy libicu-dev python3-pip

# Set the working directory.
RUN mkdir -p /usr/src/nlpserver
WORKDIR /usr/src/nlpserver
COPY . .

# Install dependencies
RUN python3 -m pip install -r requirements.txt && \
#    polyglot download LANG:en && \
#    polyglot download LANG:ru && \
#    python3 -m spacy download en_core_web_md && \
    python3 -m spacy download ru_core_news_sm && \
    python3 -m spacy download ru_core_news_md && \
    python3 -m spacy download ru_core_news_lg
#    python3 -m spacy download xx_ent_wiki_sm

# Set supervisor config
COPY docker/nlpserver.conf /etc/supervisor/conf.d
COPY docker/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
 
EXPOSE 6400
