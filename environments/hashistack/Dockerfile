FROM ubuntu:18.04

RUN  mkdir -p /stack
COPY . /stack
WORKDIR /stack

ENV SHELL /bin/bash

RUN apt-get update
RUN apt-get update 
RUN apt-get -y install curl sudo unzip vim gpg lsb-release
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

RUN chmod +x /stack/build/*.sh 

RUN echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER root
RUN /stack/build/*.sh

USER docker
ENTRYPOINT ["tail", "-f", "/dev/null"]
