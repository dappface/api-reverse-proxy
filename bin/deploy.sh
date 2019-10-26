#!/bin/sh

set -o errexit
set -o xtrace

if [ "$GITHUB_EVENT_NAME" = "release" ] ; then
  export PROJECT_ID=dappface-prd-v2
  export SUBDOMAIN=api
  export CLOUD_RUN_ID=uh5q76axrq
elif [ "$GITHUB_EVENT_NAME" = "push" ] && [ $(basename  "$GITHUB_REF") = 'master' ] ; then
  export PROJECT_ID=dappface-stg-v2
  export SUBDOMAIN=api.stg
  export CLOUD_RUN_ID=vrn4yflmpa
else
	export PROJECT_ID=dappface-dev
  export SUBDOMAIN=api.dev
  export CLOUD_RUN_ID=4smlq6pe4a
fi

APP_NAME=api-reverse-proxy
IMAGE_SRC_PATH=gcr.io/"$PROJECT_ID"/"$APP_NAME"

gcloud auth configure-docker
docker build \
  --build-arg SUBDOMAIN="$SUBDOMAIN" \
  --build-arg CLOUD_RUN_ID="$CLOUD_RUN_ID"
  -t "$IMAGE_SRC_PATH":latest \
  -t "$IMAGE_SRC_PATH":"$GITHUB_SHA" .
docker push "$IMAGE_SRC_PATH":latest
docker push "$IMAGE_SRC_PATH":"$GITHUB_SHA"

gcloud beta run deploy "$APP_NAME" \
	--project "$PROJECT_ID" \
	--image "$IMAGE_SRC_PATH":latest \
	--platform managed \
	--allow-unauthenticated \
	--region us-east1 \
	--set-env-vars PROJECT_ID="$PROJECT_ID"
