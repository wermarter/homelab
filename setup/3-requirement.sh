ansible-playbook playbooks/prepare-k3s.yaml
ansible-playbook playbooks/prepare-longhorn.yaml

sudo snap install kubectl --classic
sudo snap install helm --classic
/snap/bin/kubectl completion zsh > ~/.oh-my-zsh/custom/plugins/kubectl.plugin.zsh

git clone https://github.com/techno-tim/k3s-ansible
cd k3s-ansible && git checkout v1.30.2+k3s2+tt1 && cd ..
mkdir ./k3s-ansible/inventory/my-cluster/
