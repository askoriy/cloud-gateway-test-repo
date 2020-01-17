#! /bin/bash

APIGW_HOST=${1}
PROJECT_ID=${2}

gcloud endpoints services describe $APIGW_HOST  --format="value(serviceConfig.id)" --project=$PROJECT_ID

