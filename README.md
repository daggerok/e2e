# E2E chrome image [![Build Status](https://travis-ci.org/daggerok/e2e.svg?branch=trusty-xvfb-jdk8-chrome)](https://travis-ci.org/daggerok/e2e)
automated build for docker hub

variations:

- Docker Ubuntu `Bionic 18.04`
- Docker Ubuntu `Trusty 14.04`
- Oracle Java Development Kit 8
- Chrome with chrome driver version: `73.0.3683.68`
- Firefox with gecko driver version: `0.24.0`
- X Virtual Frame Buffer (xvfb)

available images:

- **Docker Ubuntu Trusty 14.04 base image including XVFB and JDK8**
- **Docker Ubuntu Trusty 14.04 image including Chrome browser, chrome driver, XVFB and JDK8**
- **Docker Ubuntu Trusty 14.04 image including Firefox browser, gecko driver, XVFB and JDK8**
- **Docker Ubuntu Trusty 14.04 image including Firefox and Chrome browsers, theirs web-drivers, XVFB and JDK8**

tags:

__v3__

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

## Web drivers

* [Gecko firefox web driver](https://github.com/mozilla/geckodriver/releases)
  * in use: `0.24.0`
* [Google chrome web driver](http://chromedriver.chromium.org/)
  * in use: `73.0.3683.68`

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

FROM daggerok/e2e:ubuntu-xvfb-jdk8-chrome-latest
WORKDIR 'project-directory/'
ENTRYPOINT start-xvfb && ./gradlew test chrome
COPY . .

```

```dockerfile

FROM daggerok/e2e:ubuntu-xvfb-jdk8-firefox-v3
WORKDIR 'project-directory/'
ENTRYPOINT start-xvfb && ./gradlew test firefox
COPY . .

```

```dockerfile

FROM daggerok/e2e:ubuntu-xvfb-jdk8-base
RUN echo 'install browser, webdriver and use already installed and configured jdk8 + Xvfb based on Ubuntu 14.04'

```

### build test image

```bash
#prepare ./Dockerfile
docker build -t my-e2e-tests:latest .

```

### and run tests

```bash

docker run --rm --name run-my-e2e-tests my-e2e-tests:latest

```

## Reduce build time

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

Sometines it might cause some strange and not obviouse problems for `file not found` or `permission denied` topics...
So use it only if you know what you are doing and if you ready to spend time for some debugginh :)

## Git

```bash

git tag $tagName # create tag
git tag -d $tagName # remove tag
git push origin --tags # push tags
git push origin $tagName # push tag

# ie
git add .
git commit -am ...
git push origin trusty-xvfb-jdk8-chrome
git tag trusty-xvfb-jdk8-chrome-v3
git push origin --tags
```

## Upgrade flow

_do not forget update versions (for example: v3) in a readme and CI builds as well..._

- update base images if needed:
  * `bionic-xvfb-jdk8-base`
  * `trusty-xvfb-jdk8-base`
  * `ubuntu-xvfb-jdk8-base`
- next update chrome images:
  * `bionic-xvfb-jdk8-chrome`
  * `trusty-xvfb-jdk8-chrome`
  * `ubuntu-xvfb-jdk8-chrome`
- and update firefox images:
  * `bionic-xvfb-jdk8-firefox`
  * `trusty-xvfb-jdk8-firefox`
  * `ubuntu-xvfb-jdk8-firefox`
- lastly update all-in-one images:
  * `bionic-xvfb-jdk8`
  * `trusty-xvfb-jdk8`
  * `ubuntu-xvfb-jdk8`
