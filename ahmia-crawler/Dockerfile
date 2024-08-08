FROM ubuntu:22.04

USER root

# Install necessary packages
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
  cron \
  privoxy \
  apt-transport-https

# Create directory for the application
RUN mkdir -p /root/codes/
COPY . /root/codes/

# Set environment variables
ENV ES_TOR_INDEX=latest-tor
ENV ES_URL=http://elasticsearch1:9200/

# Set working directory
WORKDIR /root/codes/

COPY ./tor.list /etc/apt/sources.list.d/

RUN wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | tee /usr/share/keyrings/deb.torproject.org-keyring.gpg >/dev/null

RUN apt-get update && apt-get -y install tor deb.torproject.org-keyring

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Make shell scripts executable
RUN chmod +x ./*.sh
RUN chmod +x ./torfleet/*.sh

# Set up cron jobs
COPY dockercron /etc/cron.d/dockercron
RUN chmod 644 /etc/cron.d/dockercron

# Ensure cron logs go to a log file
RUN touch /var/log/cron.log

# Start the startup script
ENTRYPOINT ["/root/codes/startup.sh"]
