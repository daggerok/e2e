FROM ubuntu:18.04
LABEL MAINTAINER='Maksim Kostromin <daggerok@gmail.com> https://github.com/daggerok'
ENV DISPLAY=':99'                                         \
    DEBIAN_FRONTEND='noninteractive'                      \
    JAVA_HOME='/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64'
ENV PATH="${JAVA_HOME}/bin:${PATH}"
ARG JAVA_OPTS_ARGS='-Djava.net.preferIPv4Stack=true       \
                    -XX:+UnlockExperimentalVMOptions      \
                    -XX:+UseCGroupMemoryLimitForHeap      \
                    -XshowSettings:vm                     '
ENV JAVA_OPTS="${JAVA_OPTS} ${JAVA_OPTS_ARGS}"
# execute e2e tests as non root, but sudo user
USER root
RUN apt-get update --allow-releaseinfo-change -y                                                          && \
    apt-get clean -y                                                                                      && \
    apt-get install --fix-missing -y sudo openssh-server                                                  && \
    useradd -m e2e && echo 'e2e:e2e' | chpasswd                                                           && \
    adduser e2e sudo                                                                                      && \
    echo '\ne2e ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers                                              && \
    service ssh restart                                                                                   && \
    chown -R e2e:e2e /home/e2e
WORKDIR /home/e2e
USER e2e
# prepare
RUN sudo apt-get update -y --allow-releaseinfo-change                                                        \
 && sudo apt-get install --fix-missing -y wget bash software-properties-common
# jdk8
RUN ( wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add - )     && \
    sudo apt-add-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/                         && \
    sudo apt-get update -y --allow-releaseinfo-change                                                     && \
    sudo apt-get install -y adoptopenjdk-8-hotspot
# xvfb stuff
RUN sudo apt-get install --fix-missing -y                                                                    \
      xvfb xorg xvfb dbus-x11 xfonts-100dpi xfonts-75dpi xfonts-cyrillic                                  && \
    echo '#!/bin/bash                      \n\
sudo chown -R e2e:e2e ~/ || true           \n\
echo "starting Xvfb..."                    \n\
sudo Xvfb -ac :99 -screen 0 1280x1024x16 & \n' >> ./start-xvfb                                            && \
    chmod +x ./start-xvfb                                                                                 && \
    sudo mv -f ./start-xvfb /usr/bin/
# cleanup and reduce image size
RUN sudo apt-get autoremove --purge -y                                                                    && \
    sudo apt-get autoclean -y                                                                             && \
    sudo apt-get clean -y                                                                                 && \
    ( rm -rf /tmp/* || true )                                                                             && \
    sudo update-ca-certificates -f
# docker exec -it
CMD /bin/bash
