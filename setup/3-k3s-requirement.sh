ansible-playbook playbooks/2-k3s-requirement.yaml

sudo snap install kubectl --classic
sudo snap install helm --classic

git clone https://github.com/techno-tim/k3s-ansible
cd k3s-ansible && git checkout b3f2a4addca25b12b755c2f89e95b26196f40e0b && cd ..
mkdir ./k3s-ansible/inventory/my-cluster/
