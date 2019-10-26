<div align="center">
  <img src="https://github.com/dappface/www.dappface.com/raw/master/static/icon-128x128.png" alt="DAPPFACE Logo" />

  <h1>DAPPFACE API Reverse Proxy</h1>

  <strong>
    <p>Reverse proxy server that glues Go and Rust endpoints.</p>
  </strong>

  <p>
    <a href="https://github.com/dappface/api-reverse-proxy/actions?workflow=Deploy">
      <img src="https://github.com/dappface/api-reverse-proxy/workflows/Deploy/badge.svg" />
    </a>
  </p>
</div>

## Start Docker Container

```sh
docker build -t dappface-api <path-to-api-project>
docker run --name dappface-api --rm -p 8080:8080 -e PROJECT_ID=$PROJECT_ID -e HOME=$HOME -v $HOME:$HOME dappface-api

docker build \
  --build-arg SUBDOMAIN="$SUBDOMAIN" \
  --build-arg CLOUD_RUN_ID="$CLOUD_RUN_ID" \
  -t dappface-api-proxy .
docker run -it --rm -p 80:80 --link dappface-api:dappface-api dappface-api-proxy
```
