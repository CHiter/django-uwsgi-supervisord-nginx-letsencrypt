FROM ubuntu:16.04

MAINTAINER WEB APP

# Install required packages and remove the apt packages cache when done.

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    git \
    gdal-bin \
    python3 \
    python3-gdal \
    python3-dev \
    python3-setuptools \
    python3-pip \
    supervisor \
    cron \
    nano \
    sqlite3 && \
    pip3 install -U pip setuptools && \
   rm -rf /var/lib/apt/lists/*

# install uwsgi now because it takes a little while
RUN pip3 install uwsgi

# install requirements
COPY requirements.txt /home/docker/code/
RUN pip3 install -r /home/docker/code/requirements.txt

# setup all the configfiles
COPY configs/supervisor/supervisor-app.conf /etc/supervisor/conf.d/
