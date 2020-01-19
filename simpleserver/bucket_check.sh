#! /bin/bash

PROJECT_ID=${1}
REGION=${2}
BUCKET_NAME=${3}

gsutil mb -p ${PROJECT_ID} -l ${REGION} -c standard -b on gs://${BUCKET_NAME}
if [ $? -eq 0 ]; then
    echo "bucket is created"
else
   echo "Name's been taken...add some sufix"
   gsutil mb -p ${PROJECT_ID} -l ${REGION} -c standard -b on gs://${BUCKET_NAME}-1234a
fi