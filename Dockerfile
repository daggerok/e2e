FROM daggerok/e2e:bionic-xvfb-jdk8-base-v4
LABEL MAINTAINER='Maksim Kostromin <daggerok@gmail.com> https://github.com/daggerok'
USER e2e
ENV DISPLAY=':99'                   \
    CHROME_DRV_VER='80.0.3987.106'  \
    DEBIAN_FRONTEND='noninteractive'
# chrome
ENV CHROME_BASE_URL='https://dl.google.com/linux/direct'
RUN sudo apt-get install --fix-missing -yqq                                                            \
      fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0                                \
      libatk1.0-0 libcairo2 libcups2 libgdk-pixbuf2.0-0 libgtk-3-0                                     \
      libnspr4 libnss3 libx11-xcb1 libxss1 xdg-utils                                                && \
    wget -O google-chrome-stable.deb ${CHROME_BASE_URL}/google-chrome-stable_current_amd64.deb      && \
    sudo dpkg -i google-chrome-stable.deb                                                           && \
    sudo rm -rf ./google-chrome-stable.deb
# chrome driver
ENV CHROME_DRV_BASE_URL="https://chromedriver.storage.googleapis.com/${CHROME_DRV_VER}"
RUN wget ${CHROME_DRV_BASE_URL}/chromedriver_linux64.zip                                            && \
    sudo apt-get install --fix-missing -y unzip                                                     && \
    unzip chromedriver_linux64.zip                                                                  && \
    sudo mv -f chromedriver /usr/bin/                                                               && \
    sudo rm -rf chromedriver_linux64.zip
# cleanup and reduce image size
RUN echo 'cleanup'                                                                                  && \
    sudo apt-get autoremove --purge -y                                                              && \
    sudo apt-get autoclean -y                                                                       && \
    sudo apt-get clean -y                                                                           && \
    sudo rm -rf /tmp/* || true                                                                      && \
    sudo update-ca-certificates -f
# docker exec -it
CMD /bin/bash
