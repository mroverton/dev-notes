---
layout: default
---
- [home](/index.md)
- [cloud](/cloud.md)
---
# Ansible
- https://docs.ansible.com/ansible/latest/index.html
## Modules
### List
`ansible-doc -l`
### Documentation
`ansible-doc <module-name>`
### Debugging
```
ansible-playbook -C -i ansible.inv ../ansible/host-setup.yml --list-tasks
ansible-playbook -C -i ansible.inv ../ansible/host-setup.yml -t tagname
ansible-playbook -C -i ansible.inv ../ansible/host-setup.yml -t tagname -vvv
```


## Terraform Setup
```
# =============================================================================
#  Ansible
data "template_file" "inv" {
  template = file("${path.module}/ansible/inventory.tpl")
  vars = {
    host         = aws_instance.inst1.private_ip
    ansible_user = local.ansible_user
  }
}
resource "local_file" "ansible-inventory" {
  content  = data.template_file.inv.rendered
  filename = "${path.module}/host.inv"
}
data "template_file" "ssh" {
  template = file("${path.module}/ansible/ssh-config.tpl")
  vars = {
    private_ip      = aws_instance.inst1.private_ip
    fqdn            = "${local.hostname}.${local.domain}"
    ansible_user    = local.ansible_user
    ansible_ssh_key = local.ansible_key
    bastion_id      = local.ansible_bastion
  }
}
resource "local_file" "ssh-config" {
  content  = data.template_file.ssh.rendered
  filename = "${path.module}/ssh.cfg"
}
# inventory.tpl
[hostgroup1]
${host}

[all:vars]
ansible_ssh_user=${ansible_user}
ansible_ssh_common_args='-F ssh.cfg'

# ssh-config.tpl
Host ${private_ip} ${fqdn} h1
    HostName ${private_ip}
    User ${ansible_user}
    IdentityFile ${ansible_ssh_key}
    ProxyCommand ssh ${bastion_id} -W %h:%p -q

# Usage
ssh -F ./ssh.cfg h1 # check ssh
ansible -i host.inv all -m ping # check ansible connections
ansible-playbook -i host.inv ansible/setup.yml # run ansible

```