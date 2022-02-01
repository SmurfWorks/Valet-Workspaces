SHELL := /bin/bash

# Regster a new valet workspace
register:
	docker exec valet bash -c "cd workspaces/${DIR} ; valet link ${AS} ; valet secure"
	docker exec valet bash -c "cd workspaces/${DIR} ; make -f .workspace/Makefile register-workspace"

# Launch the browsersync instance of a valet project
launch:
	docker-compose up -d
	docker exec valet bash -c "pkill -f 'cross-env' &"
	docker exec -d valet bash -c "cd workspaces/${DIR} ; make -f .workspace/Makefile launch-workspace"

# Open the container instance
open:
	docker exec -w /home/valet/workspaces/${DIR} -it valet bash

# Build a new docker instance to run your workspaces
build:
	docker-compose down
	docker-compose up -d
	docker exec valet bash -c "sudo service dnsmasq start"
	docker exec valet bash -c "valet start"

# Remove all docker instances to start again
clean:
	docker-compose down
	docker container prune -f
	docker volume prune -f

# Default file structure for the secure directory if this is your first use
secure-build:
	mkdir -p secure/ssh/keys
	mkdir -p secure/vpn
	touch secure/ssh/config

# Pack your secure assets into an encrypted backup
secure-pack:
	zip -r secure.zip secure
	openssl enc -aes-256-cbc -pbkdf2 -iter 20000 -in secure.zip -out secure.zip.enc
	rm secure.zip

# Unpack your secure assets from an encrypted backup
secure-unpack:
	openssl enc -d -aes-256-cbc -pbkdf2 -iter 20000 -in secure.zip.enc -out secure.zip
	unzip secure.zip
	rm secure.zip

# Build image
image-build:
	docker build -t smurfworks/valet-workspaces:1.0.0 ./valet --network=host

# Pull image
image-pull:
	docker pull smurfworks/valet-workspaces:1.0.0
