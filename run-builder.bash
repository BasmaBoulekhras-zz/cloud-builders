#!/bin/bash -xe

# Configurable parameters
[ -z "$COMMAND" ] && echo "Need to set COMMAND" && exit 1;

USERNAME=${USERNAME:-basma_boulekhras}
REMOTE_WORKSPACE=${REMOTE_WORKSPACE:-/home/${USERNAME}/workspace/}
INSTANCE_NAME=${INSTANCE_NAME:-test}
ZONE=${ZONE:-us-central1-b}
INSTANCE_ARGS=${INSTANCE_ARGS:---preemptible}

gcloud config set compute/zone ${ZONE}

KEYNAME=builder-key

#ssh-keygen -t rsa -f ${KEYNAME} -C ${USERNAME}
ssh-keygen -t rsa -f ~/.ssh/${KEYNAME} -C ${USERNAME}
#chmod 400 ${KEYNAME}*
chmod 400 ~/.ssh/${KEYNAME}

cat > ssh-keys <<EOF
${USERNAME}:$(cat ~/.ssh/${KEYNAME}.pub)
EOF

gcloud compute instances add-metadata ${INSTANCE_NAME} --metadata block-project-ssh-keys=TRUE --metadata-from-file ssh-keys=ssh-keys

#Check if the instance's metadata is updated
gcloud compute instances describe ${INSTANCE_NAME}

#Remove any existing files or directories from the remote instance
function cleanup {
    rm -rf ${USERNAME}@${INSTANCE_NAME}:${REMOTE_WORKSPACE}
}

#Copy the Workspace to the remote instance
gcloud compute scp --compress --recurse ./ ${USERNAME}@${INSTANCE_NAME}:${REMOTE_WORKSPACE} --ssh-key-file=~/.ssh/${KEYNAME}

#ssh connection to the remote instance
gcloud compute ssh --ssh-key-file=~/.ssh/${KEYNAME} ${USERNAME}@${INSTANCE_NAME} -- ${COMMAND} 
