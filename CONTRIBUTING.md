# Development Guide

## upgrade flow

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

## git release

```bash
git tag $tagName # create tag
git tag -d $tagName # remove tag
git push origin --tags # push tags
git push origin $tagName # push tag

# ie
git add .
git commit -am ...
git push origin master
git tag bionic-xvfb-jdk8-firefox-v4
git push origin --tags
```
