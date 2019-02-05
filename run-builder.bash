#!/bin/bash -xe

# Configurable parameters
[ -z "$COMMAND" ] && echo "Need to set COMMAND" && exit 1;

USERNAME=${USERNAME:-admin}
REMOTE_WORKSPACE=${REMOTE_WORKSPACE:-/home/${USERNAME}/workspace/}
INSTANCE_NAME=${INSTANCE_NAME:-builder-$(cat /proc/sys/kernel/random/uuid)}
ZONE=${ZONE:-us-central1-b}

gcloud config set compute/zone ${ZONE}

gcloud compute ssh --ssh-key-file=ssh-keys/public-ssh-keys.txt test --command "ps -ejH" --dry-run