#!/bin/bash -xe

# Configurable parameters
[ -z "$COMMAND" ] && echo "Need to set COMMAND" && exit 1;

USERNAME=${USERNAME:-basma_boulekhras}
REMOTE_WORKSPACE=${REMOTE_WORKSPACE:-/home/${USERNAME}/workspace/}
INSTANCE_NAME=${INSTANCE_NAME:-test}
ZONE=${ZONE:-us-central1-b}

gcloud config set compute/zone ${ZONE}

KEYNAME=builder-key

#ssh-keygen -t rsa -N "" -f ${KEYNAME} -C ${USERNAME} || true

ssh-keygen -t rsa -f ${KEYNAME} -C ${USERNAME}
chmod 400 ${KEYNAME}*

cat > ssh-keys <<EOF
${USERNAME}:$(cat ${KEYNAME}.pub)
EOF

gcloud compute instances add-metadata ${INSTANCE_NAME} --metadata block-project-ssh-keys=TRUE --metadata-from-file ssh-keys=ssh-keys

#Check if the instance's metadata is updated
gcloud compute instances describe ${INSTANCE_NAME}

##gcloud compute ssh --ssh-key-file=ssh-keys/public-ssh-keys.txt test -- ${COMMAND} --dry-run

gcloud compute ssh --ssh-key-file=${KEYNAME} ${USERNAME}@${INSTANCE_NAME} -- ${COMMAND} 
