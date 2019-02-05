#!/bin/bash -xe

deploy(branch,build) {

    sh("helm upgrade --install backend k8s/contacts-service/ --set image.tag=branch.build")
    
    
}
