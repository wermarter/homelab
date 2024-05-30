ansible-playbook playbooks/2-requirement.yaml

sudo snap install kubectl --classic
sudo snap install helm --classic
/snap/bin/kubectl completion zsh > ~/.oh-my-zsh/custom/plugins/kubectl.plugin.zsh

git clone https://github.com/techno-tim/k3s-ansible
cd k3s-ansible && git checkout f50d335451cb186a7f2e8cb8f2e5285b30f66bc0 && cd ..
mkdir ./k3s-ansible/inventory/my-cluster/
