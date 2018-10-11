#!/bin/bash

# Bump the app version number and deploy.

set -eu

# Terminal color codes and reset.
red=$(printf "\e[31m")
green=$(printf "\e[32m")
yellow=$(printf "\e[33m")
bold=$(printf "\e[1m")
TR=$(printf "\e[0m")

source config.sh

image_ver=$(( $image_ver + 1 ))

# Write updated version to config.sh
# sed inline editing isn't portable, so we use ed instead.
printf ",s/^image_ver=.*/image_ver=$image_ver/\nw\n" | ed config.sh >/dev/null

# Get the new image name.
source config.sh

gcloud config set project $project_id

docker build -t $image .
docker push $image
kubectl set image deployment/$project $project=$image

echo -e "\n${green}Done!$TR Rolling update is being applied. Here's your app IP address:\n"
kubectl get service
