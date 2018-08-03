FROM daggerok/e2e:trusty-xvfb-jdk8-base-v1
LABEL MAINTAINER='Maksim Kostromin <daggerok@gmail.com> https://github.com/daggerok'
ENV DISPLAY=':99' \
    CHROME_DRV_VER='2.41'
# chrome
RUN sudo apt-get update -y \
 && sudo apt-get clean -y \
 && sudo apt-get install --fix-missing -y \
      fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 \
      libatk1.0-0 libcairo2 libcups2 libgdk-pixbuf2.0-0 libgtk-3-0 \
      libnspr4 libnss3 libx11-xcb1 libxss1 xdg-utils \
 && wget -O google-chrome-stable.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
 && sudo dpkg -i google-chrome-stable.deb \
 && rm -rf ./google-chrome-stable.deb
# chrome driver
RUN wget https://chromedriver.storage.googleapis.com/${CHROME_DRV_VER}/chromedriver_linux64.zip \
 && unzip chromedriver_linux64.zip \
 && sudo mv -f chromedriver /usr/bin/ \
 && rm -rf chromedriver_linux64.zip
# cleanup and reduce image size
RUN sudo apt-get autoremove --purge -y \
 && sudo apt-get autoclean -y \
 && sudo apt-get clean -y \
 && rm -rf /tmp/* || true
# docker exec -it
CMD /bin/bash
