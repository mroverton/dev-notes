---
layout: default
---
- [home](/index.md)
- [cloud](/cloud.md)
---
### Sample
```
{
  "variables": {
    "profile": "ni-dev",
    "region": "us-west-2"
  },
  "builders": [
    {
      "type": "amazon-ebs",
      "access_key": "{{user `aws_access_key`}}",
      "secret_key": "{{user `aws_secret_key`}}",
      "ami_name": "packer-base-ami-{{timestamp}}",
      "instance_type": "t2.large",
      "region": "us-west-2",
      "ami_regions": ["us-west-2","us-east-1"],
      "ssh_username": "ubuntu",
      "source_ami_filter": {
        "filters": {
          "virtualization-type": "hvm",
          "name": "ubuntu/images/*ubuntu-bionic-18.04-amd64-server-*",
          "root-device-type": "ebs"
        },
        "owners": ["099720109477"],
        "most_recent": true
      }
    }
  ],
  "provisioners": [
    {
      "type": "chef-solo",
      "cookbook_paths": [
        "../cookbooks"
      ],
      "run_list": [
        "dn2k::base-setup-docker"
      ],
      "execute_command": "{{if .Sudo}}sudo {{end}}chef-solo --chef-license accept-silent --no-color -c {{.ConfigPath}} -j {{.JsonPath}}"
    }
  ]
}

```