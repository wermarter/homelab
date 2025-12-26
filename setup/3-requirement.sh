ansible-playbook playbooks/prepare-k3s.yaml
ansible-playbook playbooks/prepare-longhorn.yaml

sudo snap install kubectl --classic
sudo snap install helm --classic
/snap/bin/kubectl completion zsh > ~/.oh-my-zsh/custom/plugins/kubectl.plugin.zsh

git clone https://github.com/panoptikoe/k3s-ansible
mkdir ./k3s-ansible/inventory/my-cluster/
