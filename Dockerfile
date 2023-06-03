FROM ubuntu:20.04
MAINTAINER Blawuken <jarbull87@gmail.com>

ENV TZ Asia/Jakarta
WORKDIR /github/asoy

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install apt-utils unzip ca-certificates fuse sudo git rsync gnupg2 aria2 lolcat wget curl nano openssh-server openssh-client sshpass \
    && curl https://mega.nz/linux/MEGAsync/xUbuntu_20.04/amd64/megacmd_1.5.1-1.1_amd64.deb --output megacmd.deb \
    && echo path-include /usr/share/doc/megacmd/* > /etc/dpkg/dpkg.cfg.d/docker \
    && apt install ./megacmd.deb -y

RUN git config --global user.name Blawuken \
    && git config --global user.email jarbull87@gmail.com \
    && git config --global color.ui auto

RUN apt-get install tzdata \
    && apt-mark hold tzdata \
    && ln -snf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime \
    && echo Asia/Jakarta > /etc/timezone

WORKDIR /github/asoy
VOLUME ["/github/asoy"]
ENTRYPOINT ["/bin/bash"]
