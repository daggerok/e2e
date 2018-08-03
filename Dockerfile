FROM daggerok/e2e:trusty-xvfb-jdk8-base-v1
LABEL MAINTAINER='Maksim Kostromin <daggerok@gmail.com> https://github.com/daggerok'
ENV DISPLAY=':99' \
    GECKO_DRV_VER='0.21.0'
# firefox
RUN sudo add-apt-repository ppa:mozillateam/firefox-next \
 && sudo apt-get update -y \
 && sudo apt-get clean -y \
 && sudo apt-get install --fix-missing -y firefox
# gecko driver
RUN wget https://github.com/mozilla/geckodriver/releases/download/v${GECKO_DRV_VER}/geckodriver-v${GECKO_DRV_VER}-linux64.tar.gz \
 && tar -xvzf geckodriver* \
 && sudo mv -f geckodriver /usr/bin/ \
 && sudo chmod +x /usr/bin/geckodriver \
 && rm -rf geckodriver-v${GECKO_DRV_VER}-linux64.tar.gz
# cleanup and reduce image size
RUN sudo apt-get autoremove --purge -y \
 && sudo apt-get autoclean -y \
 && sudo apt-get clean -y \
 && rm -rf /tmp/* || true
# docker exec -it
CMD /bin/bash
