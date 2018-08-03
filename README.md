# E2E base image [![Build Status](https://travis-ci.org/daggerok/e2e.svg?branch=precise-xvfb-jdk8-base)](https://travis-ci.org/daggerok/e2e)
automated build for docker hub

stack:

- Docker Ubuntu `Trusty 14.04`
- Docker Ubuntu `Precise 12.04`
- Oracle Java Development Kit 8
- Chrome with chrome driver version: `2.41`
- Firefox with gecko driver version: `0.21.0`
- Установка X Virtual Frame Buffer (xvfb)

available images:

- **Docker Ubuntu Trusty 14.04 base image including XVFB and JDK8**
- **Docker Ubuntu Trusty 14.04 image including Chrome browser, chrome driver, XVFB and JDK8**
- **Docker Ubuntu Trusty 14.04 image including Firefox browser, gecko driver, XVFB and JDK8**
- **Docker Ubuntu Trusty 14.04 image including Firefox and Chrome browsers, theirs web-drivers, XVFB and JDK8**

tags:

- [ubuntu-xvfb-jdk8](https://github.com/daggerok/e2e/tree/ubuntu-xvfb-jdk8-v1)
- [ubuntu-xvfb-jdk8-chrome](https://github.com/daggerok/e2e/tree/ubuntu-xvfb-jdk8-chrome-v1)
- [ubuntu-xvfb-jdk8-firefox](https://github.com/daggerok/e2e/tree/ubuntu-xvfb-jdk8-firefox-v1)
- [ubuntu-xvfb-jdk8-base](https://github.com/daggerok/e2e/tree/ubuntu-xvfb-jdk8-base-v1)

- [trusty-xvfb-jdk8](https://github.com/daggerok/e2e/tree/trusty-xvfb-jdk8-v1)
- [trusty-xvfb-jdk8-chrome](https://github.com/daggerok/e2e/tree/trusty-xvfb-jdk8-chrome-v1)
- [trusty-xvfb-jdk8-firefox](https://github.com/daggerok/e2e/tree/trusty-xvfb-jdk8-firefox-v1)
- [trusty-xvfb-jdk8-base](https://github.com/daggerok/e2e/tree/trusty-xvfb-jdk8-base-v1)

- [precise-xvfb-jdk8](https://github.com/daggerok/e2e/tree/precise-xvfb-jdk8-v1)
- [precise-xvfb-jdk8-chrome](https://github.com/daggerok/e2e/tree/precise-xvfb-jdk8-chrome-v1)
- [precise-xvfb-jdk8-firefox](https://github.com/daggerok/e2e/tree/precise-xvfb-jdk8-firefox-v1)
- [precise-xvfb-jdk8-base](https://github.com/daggerok/e2e/tree/precise-xvfb-jdk8-base-v1)

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

FROM daggerok/e2e:ubuntu-xvfb-jdk8-firefox-v1
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
git push origin precise-xvfb-jdk8-base
git tag precise-xvfb-jdk8-base-v1
git push origin --tags
```
