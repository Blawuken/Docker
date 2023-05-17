FROM ubuntu:20.04
MAINTAINER Blawuken <jarbull87@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C
ENV USE_CCACHE=1
ENV ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx120G"
ENV JAVA_OPTS=" -Xmx120G "
ENV TZ Asia/Jakarta
WORKDIR /root

COPY . .

RUN apt-get -yqq update \
    && apt-get install --no-install-recommends -yqq apt-utils sudo git aria2 make cmake --fix-broken --fix-missing \
    && bash android_build_env.sh \
    && sed -i 's/cd -/cd ../g' install_android_sdk.sh \
    && bash install_android_sdk.sh

RUN git config --global user.name Blawuken \
    && git config --global user.email jarbull87@gmail.com \
    && git config --global color.ui auto

RUN groupadd -g 1000 -r ${USER} \
    && useradd -u 1000 --create-home -r -g ${USER} ${USER}

RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER} \
    && usermod -aG sudo ${USER}

RUN apt-get install tzdata \
    && apt-mark hold tzdata \
    && ln -snf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime \
    && echo Asia/Jakarta > /etc/timezone

WORKDIR /root
VOLUME ["/root/anggit86", "/root/nfs86"]
ENTRYPOINT ["/bin/bash"]
