FROM ubuntu:latest
MAINTAINER Blawuken <jarbull87@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C
ENV USE_CCACHE=1
ENV ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx120G"
ENV JAVA_OPTS=" -Xmx120G "
ENV TZ Asia/Jakarta
WORKDIR /root

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install apt-utils sudo git aria2 wget curl nano openssh-server openssh-client sshpass \
    && wget --no-check-certificate https://mega.nz/linux/MEGAsync/xUbuntu_21.10/amd64/megacmd-dbg_1.5.1-1.1_amd64.deb \
    && echo path-include /usr/share/doc/megacmd/* > /etc/dpkg/dpkg.cfg.d/docker \
    && apt install ./megacmd-dbg_1.5.1-1.1_amd64.deb -y

RUN git config --global user.name Blawuken \
    && git config --global user.email jarbull87@gmail.com \
    && git config --global color.ui auto

RUN apt-get install tzdata \
    && apt-mark hold tzdata \
    && ln -snf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime \
    && echo Asia/Jakarta > /etc/timezone

WORKDIR /root
VOLUME ["/root/anggit86", "/root/nfs86"]
ENTRYPOINT ["/bin/bash"]
