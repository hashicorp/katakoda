FROM ubuntu:16.04

RUN  mkdir -p /stack
COPY . /stack
WORKDIR /stack

ENV SHELL /bin/bash

RUN apt-get update && apt-get -y install \
  lsb-release \
  software-properties-common \
  apt-transport-https \
  ca-certificates \
  curl \
  sudo \
  unzip \
  vim 

RUN useradd -m docker && echo "docker:docker" | chpasswd \
  && adduser docker sudo \
  &&  echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
  && chmod +x /stack/build/*.sh \
  && /stack/build/*.sh

USER docker

ENTRYPOINT ["tail", "-f", "/dev/null"]
