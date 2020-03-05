# tests

_docker is required_

```bash
docker build -t daggerok/e2e-tests:`date +%Y-%m-%d` -f `pwd`/tests/Dockerfile.firefox `pwd`/tests
docker volume create e2e-data || echo 'oops, volume exists...'
docker run --rm --name run-`date +%Y-%m-%d`-e2e-tests \
  -v e2e-data:/home/e2e/.gradle/caches/modules-2/files-2.1 \
  -v e2e-data:/home/e2e/.m2/repository \
  daggerok/e2e-tests:`date +%Y-%m-%d`
```
