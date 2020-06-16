FROM ubuntu:16.04

RUN  mkdir -p /stack
COPY . /stack
WORKDIR /stack

ENV SHELL /bin/bash

RUN apt-get update
RUN apt-get update 
RUN apt-get -y  install curl sudo unzip vim
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

RUN chmod +x /stack/build/*.sh 

RUN echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER docker
RUN /stack/build/*.sh

ENTRYPOINT ["tail", "-f", "/dev/null"]
