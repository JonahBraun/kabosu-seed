## Kabosu Seed

A [randomness beacon](https://cloud.google.com/sdk/install) compatible with NIST. 

**Status**: Currently not a randomness beacon.

Dependencies:
- Go: https://golang.org/dl/
- Google Cloud SDK: https://cloud.google.com/sdk/install


## Setup

Run `./setup.sh`. This will create a Cloud project for you and deploy the project.


## Running Locally

App Engine can package the app and run it locally in a container:

```
dev_appserver.py app.yaml
```

Usually this launches a web server at: http://localhost:8080


## Deploying

To redeploy updates from the current directory:

```
gcloud app deploy
```
