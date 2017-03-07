FROM debian:jessie-backports
MAINTAINER Eric Drechsel

RUN apt-get update
RUN apt-get -t jessie-backports install -y ikiwiki
RUN apt-get install -y fcgiwrap

RUN useradd -ms /bin/bash ikiwiki
WORKDIR /home/ikiwiki
USER ikiwiki
RUN git config --global user.email "ikiwiki@pdxhub.org" && \
  git config --global user.name "Iki Wiki"
RUN export USER=ikiwiki ; \
  echo $'wiki\n\nadmin\nadmin\nadmin' | \
  ikiwiki --setup /etc/ikiwiki/auto.setup && \
  ikiwiki --changesetup wikiwiki.setup --plugin 404 && \
  ikiwiki --setup wikiwiki.setup

