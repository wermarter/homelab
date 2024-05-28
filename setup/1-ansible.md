## install Ansible

sudo apt-add-repository ppa:ansible/ansible

sudo apt update && sudo apt upgrade -y

sudo apt install ansible ansible-lint

## passwordless ssh

cd ~/.ssh

ssh-keygen -f k8s-nodes

config host file /etc/hosts

code ./config
```
Host localhost
  AddKeysToAgent yes
  IdentityFile ~/.ssh/k8s-nodes

Host gintoki
  AddKeysToAgent yes
  IdentityFile ~/.ssh/k8s-nodes

Host kagura
  AddKeysToAgent yes
  IdentityFile ~/.ssh/k8s-nodes

Host shinpachi
  AddKeysToAgent yes
  IdentityFile ~/.ssh/k8s-nodes
```

ssh-copy-id -i k8s-nodes gintoki

## passwordless sudo

sudo visudo

add this to end-of-file: `werma ALL=(ALL) NOPASSWD: ALL`

do this for every target

## test connection

ansible workers -b -a "ufw status"