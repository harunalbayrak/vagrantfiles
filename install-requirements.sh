#!/bin/bash

set -x

installDocker(){
	sudo apt-get update	
	sudo apt-get install -y \
	    ca-certificates \
	    curl \
	    gnupg \
	    lsb-release

	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	echo \
	  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
	  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

	sudo apt-get update
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

	sudo usermod -aG docker $USER
	newgrp docker
}

installVagrant(){
	sudo apt update
	sudo apt install virtualbox

	sudo curl -O https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.deb
	sudo apt install ./vagrant_2.2.9_x86_64.deb
}

checkRequirements(){
	dockerdir=$(command -v docker)
	if [ -x "$dockerdir" ]; then
	    echo "Docker: $dockerdir"
	else
	    echo "Docker should be installed!"
	fi

	vagrantdir=$(command -v vagrant)
	if [ -x "$vagrantdir" ]; then
	    echo "Vagrant: $vagrantdir"
	else
	    echo "Vagrant should be installed!"
	fi
}

installDocker
installVagrant
checkRequirements
