all : remote galaxy playbook

playbook :
	ansible-playbook ./playbook.yml

galaxy :
	ansible-galaxy install -p roles -r requirements.yml --ignore-errors

ping :
	ansible -m ping all

remote :
	ssh root@db2.kiiiosk.ru "sudo apt-get update && sudo apt-get install -y software-properties-common && sudo apt-add-repository ppa:ansible/ansible && sudo apt-get update && sudo apt-get install -y ansible"
