all : galaxy

play :
	ansible-playbook ./playbook.yml -i hosts

galaxy :
	ansible-galaxy install -p roles -r requirements.yml --ignore-errors

ping :
	ansible -m ping all

install :
	ssh root@${SETUP_HOST} "which ansible || (sudo apt-get update && sudo apt-get install -y software-properties-common && sudo apt-add-repository ppa:ansible/ansible && sudo apt-get update && sudo apt-get install -y ansible)"

