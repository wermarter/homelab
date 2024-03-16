ansible-playbook playbooks/1-shell.yaml -i "gintoki,kaguya,shinpachi" -K
ansible all -a "date"
ansible gintoki -a "free -h"