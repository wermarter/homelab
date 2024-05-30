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
  
Host kagura
  AddKeysToAgent yes
  IdentityFile ~/.ssh/homelab
  
Host shinpachi
  AddKeysToAgent yes
  IdentityFile ~/.ssh/homelab

Host sadaharu
  AddKeysToAgent yes
  IdentityFile ~/.ssh/homelab
```

ssh-copy-id -i ~/.ssh/homelab localhost
ssh-copy-id -i ~/.ssh/homelab kagura
ssh-copy-id -i ~/.ssh/homelab shinpachi
ssh-copy-id -i ~/.ssh/homelab sadaharu

## install Ansible

sudo apt-add-repository ppa:ansible/ansible

sudo apt update && sudo apt upgrade -y

sudo apt install ansible

## test connection

ansible all -b -a "ufw status"