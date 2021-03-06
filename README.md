# E2E image [![Build Status](https://travis-ci.org/daggerok/e2e.svg?branch=master)](https://travis-ci.org/daggerok/e2e) [![Firefox e2e tests](https://github.com/daggerok/e2e/workflows/Firefox%20e2e%20tests/badge.svg)](https://github.com/daggerok/e2e/actions) [![Chrome e2e tests](https://github.com/daggerok/e2e/workflows/Chrome%20e2e%20tests/badge.svg)](https://github.com/daggerok/e2e/actions?query=workflow%3A%22Chrome+e2e+tests%22)
Automated e2e base image build for Docker Hub

- Docker Ubuntu `Bionic 18.04` / `Trusty 14.04`
- Java Development Kit 8 `OpenJDK` / `AdoptOpenJDK`
- Chrome with chrome driver version: `80.0.3987.106`
- Firefox with gecko driver version: `0.26.0`
- X Virtual Frame Buffer (xvfb)

__v4__ _tags_
ww
- [ubuntu-xvfb-jdk8](https://github.com/daggerok/e2e/tree/ubuntu-xvfb-jdk8-v4)
- [bionic-xvfb-jdk8](https://github.com/daggerok/e2e/tree/bionic-xvfb-jdk8-v4)
- [bionic-xvfb-jdk8-firefox](https://github.com/daggerok/e2e/tree/bionic-xvfb-jdk8-firefox-v4)
- [bionic-xvfb-jdk8-chrome](https://github.com/daggerok/e2e/tree/bionic-xvfb-jdk8-chrome-v4)
- [bionic-xvfb-jdk8-base](https://github.com/daggerok/e2e/tree/bionic-xvfb-jdk8-base-v4)
- [trusty-xvfb-jdk8](https://github.com/daggerok/e2e/tree/trusty-xvfb-jdk8-v4)
- [trusty-xvfb-jdk8-firefox](https://github.com/daggerok/e2e/tree/trusty-xvfb-jdk8-firefox-v4)
- [trusty-xvfb-jdk8-chrome](https://github.com/daggerok/e2e/tree/trusty-xvfb-jdk8-chrome-v4)
- [trusty-xvfb-jdk8-base](https://github.com/daggerok/e2e/tree/trusty-xvfb-jdk8-base-v4)

_images_

- **Docker Ubuntu Trusty 14.04 base image including XVFB and JDK8**
- **Docker Ubuntu Trusty 14.04 image including Chrome browser, chrome driver, XVFB and JDK8**
- **Docker Ubuntu Trusty 14.04 image including Firefox browser, gecko driver, XVFB and JDK8**
- **Docker Ubuntu Trusty 14.04 image including Firefox and Chrome browsers, theirs web-drivers, XVFB and JDK8**

<!--

__v3__ _tags_

- [bionic-xvfb-jdk8](https://github.com/daggerok/e2e/tree/bionic-xvfb-jdk8-v3)
- [bionic-xvfb-jdk8-chrome](https://github.com/daggerok/e2e/tree/bionic-xvfb-jdk8-chrome-v3)
- [bionic-xvfb-jdk8-firefox](https://github.com/daggerok/e2e/tree/bionic-xvfb-jdk8-firefox-v3)
- [bionic-xvfb-jdk8-base](https://github.com/daggerok/e2e/tree/bionic-xvfb-jdk8-base-v3)

- [ubuntu-xvfb-jdk8](https://github.com/daggerok/e2e/tree/ubuntu-xvfb-jdk8-v3)
- [ubuntu-xvfb-jdk8-chrome](https://github.com/daggerok/e2e/tree/ubuntu-xvfb-jdk8-chrome-v3)
- [ubuntu-xvfb-jdk8-firefox](https://github.com/daggerok/e2e/tree/ubuntu-xvfb-jdk8-firefox-v3)
- [ubuntu-xvfb-jdk8-base](https://github.com/daggerok/e2e/tree/ubuntu-xvfb-jdk8-base-v3)

- [trusty-xvfb-jdk8](https://github.com/daggerok/e2e/tree/trusty-xvfb-jdk8-v3)
- [trusty-xvfb-jdk8-chrome](https://github.com/daggerok/e2e/tree/trusty-xvfb-jdk8-chrome-v3)
- [trusty-xvfb-jdk8-firefox](https://github.com/daggerok/e2e/tree/trusty-xvfb-jdk8-firefox-v3)
- [trusty-xvfb-jdk8-base](https://github.com/daggerok/e2e/tree/trusty-xvfb-jdk8-base-v3)

-->

_web drivers sources_

* [Gecko firefox web driver](https://github.com/mozilla/geckodriver/releases)
* [Google chrome web driver](http://chromedriver.chromium.org/)

## Usage

### just create your test Dockerfile

```dockerfile

FROM daggerok/e2e:ubuntu-xvfb-jdk8
#/home/e2e/project-directory/
WORKDIR 'project-directory/'
ENTRYPOINT start-xvfb && ./gradlew test
COPY . .

```

```dockerfile

FROM daggerok/e2e:bionic-xvfb-jdk8-v4
WORKDIR 'some-directory/'
ENTRYPOINT start-xvfb && ./gradlew test chrome
COPY . .

```

```dockerfile

FROM daggerok/e2e:trusty-xvfb-jdk8
WORKDIR 'e2e-tests/'
ENTRYPOINT start-xvfb && ./gradlew test firefox
COPY . .

```

```dockerfile

FROM daggerok/e2e:trusty-xvfb-jdk8-base-v4
#FROM daggerok/e2e:bionic-xvfb-jdk8-base-v4
RUN echo 'install browser, webdriver and use already installed and configured jdk8 + Xvfb based on Ubuntu 14.04'

```

### build test image

```bash
# prepare tests/Dockerfile.firefox and build e2e test image  as usual...
docker build -f ./tests/Dockerfile.firefox -t daggerok/e2e-tests:`date +%Y-%m-%d` ./tests

```

### run tests

```bash

docker run --rm --name run-`date +%Y-%m-%d`-e2e-tests daggerok/e2e-tests:`date +%Y-%m-%d`

```

### reduce build time by using data volume

```bash

# build e2e test image  as usual...
docker build -f ./tests/Dockerfile.firefox -t daggerok/e2e-tests:`date +%Y-%m-%d` ./tests

# create re-usable e2e data volume
docker volume create e2e-data || echo 'oops, volume exists...'

# run e2e tests
docker run --rm --name run-`date +%Y-%m-%d`-e2e-tests \
  -v e2e-data:/home/e2e/.gradle/caches/modules-2/files-2.1 \
  -v e2e-data:/home/e2e/.m2/repository \
  daggerok/e2e-tests:`date +%Y-%m-%d`

```

### fix chrome

To make it possible run e2e tests in chrome, you have to in addition configure `--no-sandbox` ChromeOptions argument
in your tests, like so:

```java
// ./mvnw test -Dselenide.browser=chrome -Dselenide.headless=true
if ("chrome".equals(Configuration.browser)) && Configuration.headless) {
  ChromeOptions chromeOptions = new ChromeOptions().addArguments("--no-sandbox");
  WebDriverRunner.setWebDriver(new ChromeDriver(chromeOptions));
}
```

<!--

### reduce build time (wrong, don't do that) trigger build...

In real big projects resolving dependencies each time might take long time and sometimes it's not what we want...
So we can try reuse existing local `~/.gradle` and `~/.m2` folders to reduce build time. 
To do so, just mount needed folder on during docker run:

```bash

docker build -t my-e2e-tests:latest .
mkdir -p ~/.gradle/caches/modules-2/files-2.1 ~/.m2/repository
docker run --rm --name run-my-e2e-tests \
  -v ~/.gradle/caches/modules-2/files-2.1:/home/e2e/.gradle/caches/modules-2/files-2.1 \
  -v ~/.m2/repository:/home/e2e/.m2/repository \
  my-e2e-tests

```

**WARNING**

Sometimes it might cause some strange and not obvious problems for `file not found` or `permission denied` topics...
So use it only if you know what you are doing and if you ready to spend time for some debugging :)

-->
