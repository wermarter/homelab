## passwordless ssh

```
Host gintoki
  HostName 192.168.1.11
  AddKeysToAgent yes
  IdentityFile ~/.ssh/homelab

Host kagura
  HostName 192.168.1.12
  AddKeysToAgent yes
  IdentityFile ~/.ssh/homelab

Host shinpachi
  HostName 192.168.1.13
  AddKeysToAgent yes
  IdentityFile ~/.ssh/homelab

Host sadaharu
  HostName 192.168.1.14
  AddKeysToAgent yes
  IdentityFile ~/.ssh/homelab
```

ssh-copy-id -i ~/.ssh/homelab kagura
ssh-copy-id -i ~/.ssh/homelab shinpachi
ssh-copy-id -i ~/.ssh/homelab sadaharu

## passwordless sudo

sudo visudo

add this to **end-of-file**: `werma ALL=(ALL) NOPASSWD: ALL`

## install Ansible

sudo apt-add-repository ppa:ansible/ansible

sudo apt update && sudo apt upgrade -y

sudo apt install -y ansible

## test connection

ansible all -b -a "ufw status"
