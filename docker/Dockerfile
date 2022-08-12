# Use the official image as a parent image.
FROM python:3.8.5-slim-buster

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git supervisor pkg-config python-numpy libicu-dev python3-pip

# Set the working directory.
WORKDIR /usr/src
ARG CACHE_BURST=1
RUN git clone https://github.com/dimusik/nlpserver.git
WORKDIR /usr/src/nlpserver

# Install dependencies
RUN python3 -m pip install -r requirements.txt && \
    polyglot download LANG:en && \
    polyglot download LANG:ru && \
    python3 -m spacy download en_core_web_md && \
    python3 -m spacy download ru_core_news_md && \
    python3 -m spacy download ru_core_news_lg && \
    python3 -m spacy download xx_ent_wiki_sm

# Set supervisor config
COPY nlpserver.conf /etc/supervisor/conf.d
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
 
EXPOSE 6400
