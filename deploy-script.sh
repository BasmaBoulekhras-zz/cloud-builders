#!/bin/bash -xe

ZONE=us-central1-b
CLUSTER=adolfo-test

deploy() {

  if [ "$1" == "master" -o "$1" == "develop" ] 
  then
    gcloud container clusters get-credentials --zone ${ZONE} ${CLUSTER}
    helm upgrade --install "$3" "$4" --set image.tag=$1.$2
  else
  
    exit 0
    
  fi   
    
}
