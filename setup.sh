#!/usr/bin/env bash

# setup.sh creates a new Google Cloud project and deploys the application.

# Exit on command error, unset vars, errors inside of pipes.
set -euo pipefail


###############################################################################
# Functions

# Print the error message and exit.
err() {
	echo "$@" >&2 && exit 1
}

# Print a string of random numbers $1 digits long.
rand_id() {
	for i in `seq 1 $1`; do echo -n $(( RANDOM % 10 )); done
}

check_dependencies() {
	[[ $(type -P "go") ]] || err "Please install Go: https://golang.org/dl/"
	[[ $(type -P "gcloud") ]] || err "Please install Google Cloud SDK: https://cloud.google.com/sdk/install"
}


###############################################################################
# Main

check_dependencies

# Gcloud project IDs must be unique. This is a cheap hack to get a reasonably
# random project id similar to how Google generates them.
project_id="kabosu-seed-$(rand_id 12)"

cat <<-EOD && 
	This setup script will create a new Google Cloud project and deploy the
	application.

	A unique project ID has been generated for you, or you can set your own.

EOD

read -p	"Goole Cloud project ID <$project_id>: " user_input

[[ ! -z $user_input ]] && project_id=$user_input

echo "Project ID: $project_id"
gcloud projects create $project_id --set-as-default

# Ensure Go is installed
gcloud components install app-engine-go

gcloud app deploy
