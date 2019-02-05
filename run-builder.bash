#!/bin/bash -xe

# Configurable parameters
[ -z "$COMMAND" ] && echo "Need to set COMMAND" && exit 1;

USERNAME=${USERNAME:-basmaboulekhras@gmail.com}
REMOTE_WORKSPACE=${REMOTE_WORKSPACE:-/home/${USERNAME}/workspace/}
INSTANCE_NAME=${INSTANCE_NAME:-test}
ZONE=${ZONE:-us-central1-b}

gcloud config set compute/zone ${ZONE}

gcloud compute ssh --ssh-key-file=ssh-keys/public-ssh-keys.txt test -- ${COMMAND} --dry-run
