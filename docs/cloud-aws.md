- [home](/index.md)
- [cloud](/cloud.md)
---
# AWS Notes
- [SDKs](https://aws.amazon.com/getting-started/tools-sdks/)

## CLI Tools
```
pip install awscli
pip install aws-shell
pip install awslogs
pip install apilogs
```

## S3 config
```
# ~/.aws/config
[default]
region = us-west-2
s3 =
  max_concurrent_requests = 20
  max_queue_size = 10000
  multipart_threshold = 1GB
  multipart_chunksize = 1GB
```

## S3 bucket policies
```
aws --profile myprod s3api get-bucket-policy --bucket bname |jq '.Policy | fromjson'
```

## S3 list sorted
```
# All files sorted
aws s3 ls --human-readable --recursive s3://bname/|sort|tee s3-files.sorted
```

# Pull all CloudWatch logs
```
for g in $(awslogs groups |grep interest); do 
  echo '-------'
  echo $g
  awslogs get $g ALL -s6h

done|tee 2019-04-02-my.logs

```
# List hosted zones
```
aws --profile myprod route53 list-hosted-zones |jq -c '.HostedZones[]|{name:.Name,id:.Id}'
```

# Get Account ID
https://docs.aws.amazon.com/IAM/latest/UserGuide/console_account-alias.html
```
aws sts get-caller-identity --query Account --output text
```

# Retrieving Instance Metadata
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html
```
curl http://169.254.169.254/latest/meta-data/
```

# UserData
```
cd /var/lib/cloud/instances/i-xxx/user-data.txt

# logs
less /var/log/cloud-init.log
journalctl -xu cloud-final -f
```

# EKS
## aws-iam-authenicator
- https://github.com/kubernetes-sigs/aws-iam-authenticator
```
aws eks get-token --cluster-name xxx

# get kubeconfig
aws --region us-west-2 eks update-kubeconfig --name clustername

```

