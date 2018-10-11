## Kabosu Seed

A randomness beacon inspired by the [one at NIST](https://www.nist.gov/programs-projects/nist-randomness-beacon)
running on Google Kubernetes Engine (GKE).

**Development Status:** Currently not a randomness beacon.

Dependencies:
- Google Cloud SDK: https://cloud.google.com/sdk/install
- Docker (Community Edition): https://docs.docker.com/engine/installation/

It may be helpful, but is not necessary, to install Go: https://golang.org/dl/


## Setup

1. Clone this repository locally. It is not necessary to use `go get` because
containers will be used for compilation.

2. Run `./setup.sh`. This will create a Cloud project for you and deploy the project.

After creation, project configuration is saved in `config.sh`.

If setup fails for some reason, you can safely run setup.sh again. However, the
script is not idempotent yet and will harmlessly fail after it has succeeded once.


## Running Locally

To build and run docker locally: `./run.sh`

This will launch a web server at: http://localhost:8080


## Deploying

To deploy an updated version to GKE: `./deploy.sh`

To facilitate playing with this toy project, deployments are made directly from
the source code in this directory, independent of git status.


## Autoscaling

Autoscaling has been setup with a node min/max of 3/15 and pod min/max of 3/15
with 50% target CPU utilization over all pods. 

### Autoscaling Background

The object hierarchy is: Region > Zone > Container Cluster > Node Pools > Nodes > Pods > App.

A default node pool is created by GKE. If you move to a multi-zone cluster,
remember that everything within a cluster is duplicated in every zone.

Autoscaling in GKE is done in two separate areas that work together:

- Kubernetes is responsible for scaling pods within a node cluster based on CPU usage.
- The GKE Cluster Autoscaler will scale nodes within a pool based on pod demand.

For more information, see:

- https://cloud.google.com/kubernetes-engine/docs/how-to/scaling-apps
- https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-autoscaler
