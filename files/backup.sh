#!/bin/sh

set -e

if [ -z "$MYSQL_USER" ]; then echo "MYSQL_USER needs to be set"; exit 1; fi
if [ -z "$MYSQL_PASSWORD" ]; then echo "MYSQL_PASSWORD needs to be set"; exit 1; fi
if [ -z "$MYSQL_HOST" ]; then echo "MYSQL_HOST needs to be set"; exit 1; fi
if [ -z "$MYSQL_DB" ]; then echo "MYSQL_DB needs to be set"; exit 1; fi
if [ -z "$AWS_ACCESS_KEY_ID" ]; then echo "AWS_ACCESS_KEY_ID needs to be set"; exit 1; fi
if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then echo "AWS_SECRET_ACCESS_KEY needs to be set"; exit 1; fi
if [ -z "$AWS_S3_BUCKET" ]; then echo "AWS_S3_BUCKET needs to be set"; exit 1; fi
if [ -z "$AWS_KMS_ID" ]; then echo "AWS_KMS_ID needs to be set"; exit 1; fi

dump_name=/dumps/`date "+%Y%m%d_%H%M"`_$MYSQL_DB.sql

echo "Creating mysql dump: ${dump_name}"
mysqldump -u$MYSQL_USER -p$MYSQL_PASSWORD -h$MYSQL_HOST $MYSQL_DB > $dump_name

aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
aws configure set default.region eu-west-1

echo "Uploading to s3 bucket: ${AWS_S3_BUCKET}"
aws s3 cp /dumps s3://${AWS_S3_BUCKET} --recursive --sse-kms-key-id ${AWS_KMS_ID} --sse aws:kms
