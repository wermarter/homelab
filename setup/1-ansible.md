## passwordless sudo

sudo visudo

add this to end-of-file: `werma ALL=(ALL) NOPASSWD: ALL`

do this for every target

## passwordless ssh

cd ~/.ssh

ssh-keygen -f homelab

config host file /etc/hosts

code ./config
```
Host localhost
  AddKeysToAgent yes
  IdentityFile ~/.ssh/homelab

Host gintoki
  AddKeysToAgent yes
  IdentityFile ~/.ssh/homelab

Host kagura
  AddKeysToAgent yes
  IdentityFile ~/.ssh/homelab

Host shinpachi
  AddKeysToAgent yes
  IdentityFile ~/.ssh/homelab
```

ssh-copy-id -i homelab gintoki

## install Ansible

sudo apt-add-repository ppa:ansible/ansible

sudo apt update && sudo apt upgrade -y

sudo apt install ansible ansible-lint

## test connection

ansible workers -b -a "ufw status"