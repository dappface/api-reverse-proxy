FROM nginx:alpine

WORKDIR /opt

COPY nginx.conf /etc/nginx/conf.d/
COPY bin/start.sh ./

ARG SUBDOMAIN
ARG CLOUD_RUN_ID

RUN apk --update --no-cache add ca-certificates && \
  update-ca-certificates && \
  sed -i "s/__SUBDOMAIN__/$SUBDOMAIN/g" /etc/nginx/conf.d/nginx.conf && \
  sed -i "s/__CLOUD_RUN_ID__/$CLOUD_RUN_ID/g" /etc/nginx/conf.d/nginx.conf

ENTRYPOINT ["./start.sh"]
