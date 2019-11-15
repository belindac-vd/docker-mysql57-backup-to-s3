# Docker Mysql 5.7 Backup to S3

This will deploy a one shot pod to backup a mysql db to an s3 bucket.

### Usage

Template for the pod and s3 bucket are in the templates folder.

Things to do manually:
- Create an IAM user
- Generate KMS and allow the IAM user access to it

Copy the following:
- s3.yaml to stacks-hod-platform
- pod.yaml to your project

s3.yaml:
Fill in top params

secrets.yaml:
Add base64 encoded secrets to each variable, and upload to namespace. DO NOT COMMIT THIS FILE WITH THE SECRETS TO ANY REPO.

pod.yaml:
Add this to your project, should be able to deploy to your namespace without any changes.
