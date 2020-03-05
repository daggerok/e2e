FROM daggerok/e2e:trusty-xvfb-jdk8-base-v4
LABEL MAINTAINER='Maksim Kostromin <daggerok@gmail.com> https://github.com/daggerok'
USER e2e
ENV DISPLAY=':99'                   \
    GECKO_DRV_VER='0.26.0'          \
    DEBIAN_FRONTEND='noninteractive'
# firefox
RUN echo 'firefox'                                                                                  && \
    sudo add-apt-repository -y ppa:mozillateam/firefox-next                                         && \
    sudo apt-get update -yqq --allow-releaseinfo-change || echo 'oops...'                           && \
    sudo apt-get clean -y                                                                           && \
    sudo apt-get install --fix-missing -y firefox
# gecko driver
ENV GECKO_DRV_BASE_URL="https://github.com/mozilla/geckodriver/releases/download/v${GECKO_DRV_VER}"
RUN wget ${GECKO_DRV_BASE_URL}/geckodriver-v${GECKO_DRV_VER}-linux64.tar.gz                         && \
    tar -xvzf geckodriver*                                                                          && \
    sudo mv -f geckodriver /usr/bin/                                                                && \
    sudo chmod +x /usr/bin/geckodriver                                                              && \
    sudo rm -rf geckodriver-v${GECKO_DRV_VER}-linux64.tar.gz
# cleanup and reduce image size
RUN echo 'cleanup'                                                                                  && \
    sudo apt-get autoremove --purge -y                                                              && \
    sudo apt-get autoclean -y                                                                       && \
    sudo apt-get clean -y                                                                           && \
    sudo rm -rf /tmp/* || true                                                                      && \
    sudo update-ca-certificates -f
# docker exec -it
CMD /bin/bash
