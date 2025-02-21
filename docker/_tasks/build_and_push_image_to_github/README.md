
```sh
docker build -t web_ruby:latest .
docker push web_ruby:latest
docker push ghcr.io/Zlatov/web_ruby:latest
docker image tag web_ruby:latest ghcr.io/zlatov/web_ruby:latest
docker push ghcr.io/zlatov/web_ruby:latest


docker build -t ghcr.io/zlatov/web_ruby:latest .
echo $CR_PAT | docker login ghcr.io -u zlatov --password-stdin
docker push ghcr.io/zlatov/web_ruby:latest
```
