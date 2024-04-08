## install Ansible

sudo apt-add-repository ppa:ansible/ansible

sudo apt update && sudo apt upgrade -y

sudo apt install ansible ansible-lint

## passwordless ssh

cd ~/.ssh

ssh-keygen (x4)

code ./config
```
Host madao
  AddKeysToAgent yes
  IdentityFile ~/.ssh/madao

Host gintoki
  HostName 192.168.1.11
  AddKeysToAgent yes
  IdentityFile ~/.ssh/gintoki

Host kagura
  HostName 192.168.1.12
  AddKeysToAgent yes
  IdentityFile ~/.ssh/kagura

Host shinpachi
  HostName 192.168.1.13
  AddKeysToAgent yes
  IdentityFile ~/.ssh/shinpachi
```

ssh-copy-id -i gintoki gintoki

## passwordless sudo

sudo visudo

add this to end-of-file: `werma ALL=(ALL) NOPASSWD: ALL`

do this for every target

## test connection

ansible ubuntu -m ping
ansible workers -b -a "ufw status"