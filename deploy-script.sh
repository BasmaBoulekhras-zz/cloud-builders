#!/bin/bash -xe

ZONE=us-central1-a
CLUSTER=ingress-test1	

deploy() {

  if [[ "$1" == "master" || "$1" == "develop" || "$1" == "remote-builder-test" ]];
  then
    gcloud container clusters get-credentials --zone ${ZONE} ${CLUSTER}
    helm upgrade --install "$3" "$4" --set image.tag="$1.$2" --dry-run
  else
    exit 0
  fi   
}

deploy $1 $2 $3 $4
