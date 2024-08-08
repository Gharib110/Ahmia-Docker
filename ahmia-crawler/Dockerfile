FROM ubuntu:22.04

USER root

RUN apt-get update && apt-get -y install \
  python3-pip \
  python3-dev \
  python3-lxml \
  build-essential \
  libssl-dev \
  libffi-dev \
  libxml2-dev \
  libxslt1-dev \
  openssl \
  wget \
  curl \
  unzip \
  gnupg \
  coreutils \
  cron

RUN mkdir -p /root/codes/
COPY . /root/codes/

ENV ES_TOR_INDEX=latest-tor
ENV ES_URL=http://ahmiaelasticsearch:9200/

WORKDIR /root/codes/

RUN pip3 install -r requirements.txt

RUN chmod +x ./*.sh

RUN bash ./run.sh &> crawler.log

COPY dockercron /etc/cron.d/dockercron

RUN chmod 644 /etc/cron.d/dockercron

CMD ["cron", "&&", "tail -f /var/log/cron.log"]
