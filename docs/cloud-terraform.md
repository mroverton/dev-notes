---
layout: default
---
- [home](/index.md)
- [cloud](/cloud.md)
---
# Terraform
- https://www.terraform.io/docs/index.html
- https://registry.terraform.io/
- [String functions](https://www.terraform.io/docs/configuration/functions/format.html)
- [Collection functions](https://www.terraform.io/docs/configuration/functions/merge.html)
- [life-cycle](https://www.terraform.io/docs/configuration/resources.html#lifecycle-lifecycle-customizations)
- [AWS Instance](https://www.terraform.io/docs/providers/aws/r/instance.html)
- [Examples from EKS](https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/workers.tf)
```
terraform apply -input=false -auto-approve
terraform taint -module=pruf_qa.host aws_instance.host
tf show |grep -A2 'aws_iam_access_key.user_file_'
terraform state rm module.EzFeedFeedWorker
tf destroy -force -refresh=false # when bucket is already gone
```
## Create a graph with dot
```
terraform graph | dot -Tpdf > tf-graph.pdf
```
## Debugging
https://www.terraform.io/docs/internals/debugging.html
```
export TF_LOG=DEBUG
```


## Providers
```
terraform {
  required_version = "~> 0.12"
  required_providers {
    aws      = "~> 2.58"
    spotinst = "~> 1.14"
    rancher2 = "~> 1.8"
    local    = "~> 1.2"
    null     = "~> 2.1"
    template = "~> 2.1"
    random   = "~> 2.2"
    external = "~> 1.2"
  }
  backend "s3" {
    bucket                  = "mybucketforstate"
    key                     = "path/1/2/myenv.tstate"
    shared_credentials_file = "~/.aws/somefile"
    profile                 = "profile2"
    region                  = "us-east-1"
    dynamodb_table          = "terraform-remote-state-table"
  }
}

# Read state from another run
data "terraform_remote_state" "shared" {
  backend = "s3"
  config = {
    bucket  = "bname"
    key     = "key/myenv.tstate"
    shared_credentials_file = "~/.aws/somefile"
    profile = "myprofile"
    region  = "us-east-1"
  }
}

provider "aws" {
  version                 = "~> 2.52"
  alias                   = "east"
  region                  = "us-east-1"
  shared_credentials_file = "~/.aws/account1"
  profile                 = "profile1"
}

```

## Module call with branch
```
module "some-mod" {
  source = "git::http://repo.server.com/terraform-mods/repo.git//my-mod?ref=branchname"

  # pass a provider
  providers = {
    aws = aws.myalias
  }
}
```

## Convert k/v to key/value
```
locals {
  tags_kv_master = [
    for item in keys(local.tags_master) :
    map(
      "key", item,
      "value", element(values(local.tags_master), index(keys(local.tags_master), item))
    )
  ]
}
# apply
...
  dynamic "tags" {
    for_each = local.tags_kv_master[*]
    content {
      key   = tags.value["key"]
      value = tags.value["value"]
    }
  }
...
```

## User data
```
  user_data = <<-EOF
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh ${var.cluster_name}
EOF
```
## Random String
```
resource "random_string" "suffix" {
  length  = 8
  special = false
}
```
## Read a File
```
userdata = file("userdata.sh")
```

## Read JSON File
```
locals {
  json_data = jsondecode(file("~/.aws/myfile.json"))
}
provider "xxx" {
  token   = local.json_data.token
  secret = local.json_data.secret
}
```


## Run a script
```
resource "null_resource" "script" {

  provisioner "local-exec" {
    command = <<EOT
aws --profile ${var.aws-profile} eks update-cluster-config --name ${data.acluster.cluster.name} \
--resources-vpc-config endpointPublicAccess=false,endpointPrivateAccess=true
EOT
  }
}
```
