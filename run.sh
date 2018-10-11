#!/bin/bash

# Runs the docker image locally.

set -eu

# Terminal color codes and reset.
red=$(printf "\e[31m")
green=$(printf "\e[32m")
yellow=$(printf "\e[33m")
bold=$(printf "\e[1m")
TR=$(printf "\e[0m")

source config.sh

docker build -t $project-local .

echo "${green}Running…$TR  Ctrl-c to stop. Listening at: http://localhost:8080/"
docker run --rm -p 8080:80 $project-local
