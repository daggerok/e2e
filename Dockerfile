FROM ubuntu:16.04
LABEL MAINTAINER='Maksim Kostromin <daggerok@gmail.com> https://github.com/daggerok'
ENV DISPLAY=':99' \
    DEBIAN_FRONTEND='noninteractive' \
    JAVA_HOME='/usr/lib/jvm/java-8-oracle'
ENV PATH="${JAVA_HOME}/bin:${PATH}"
ARG JAVA_OPTS_ARGS='\
-Djava.net.preferIPv4Stack=true \
-XX:+UnlockExperimentalVMOptions \
-XX:+UseCGroupMemoryLimitForHeap \
-XshowSettings:vm'
ENV JAVA_OPTS="${JAVA_OPTS} ${JAVA_OPTS_ARGS}"
# execute e2e tests as non root, but sudo user
USER root
RUN apt update -y \
 && apt-get clean -y \
 && apt install --fix-missing -y sudo openssh-server \
 && useradd -m e2e && echo 'e2e:e2e' | chpasswd \
 && adduser e2e sudo \
 && echo '\ne2e ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers \
 && service ssh restart \
 && chown -R e2e:e2e /home/e2e
WORKDIR /home/e2e
USER e2e
# prepare
RUN sudo apt-get update -y \
 && sudo apt-get install --fix-missing -y wget bash software-properties-common
# jdk8
RUN sudo apt-add-repository -y ppa:webupd8team/java \
 && sudo apt-get update -y \
 && sudo echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections \
 && sudo echo debconf shared/accepted-oracle-license-v1-1   seen true | sudo debconf-set-selections \
 && sudo apt-get install --fix-missing -y oracle-java8-installer oracle-java8-set-default oracle-java8-unlimited-jce-policy
# xvfb stuff
RUN sudo apt-get install --fix-missing -y xvfb xorg xvfb dbus-x11 xfonts-100dpi xfonts-75dpi xfonts-cyrillic \
 && echo '#!/bin/bash \n\
sudo chown -R e2e:e2e ~/ || true \n\
echo "starting Xvfb..." \n\
sudo Xvfb -ac :99 -screen 0 1280x1024x16 & \n' \
      >> ./start-xvfb \
 && chmod +x ./start-xvfb \
 && sudo mv -f ./start-xvfb /usr/bin/
# cleanup and reduce image size
RUN sudo apt-get autoremove --purge -y \
 && sudo apt-get autoclean -y \
 && sudo apt-get clean -y \
 && rm -rf /tmp/* || true
# docker exec -it
CMD /bin/bash
