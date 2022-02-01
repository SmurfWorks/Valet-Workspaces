## Setup project base

1. Get yourself a linux setup. If you're on windows, then install WSL.

2. Install docker for desktop - make sure this is running at start up so that your terminal has access to the docker commands via the make file.

3. Install some tools for valet workspaces: `sudo apt install -y make zip`

4. Optionally pull in your SSH keys and configurations, and VPN configurations. If you're pulling in a packed secure bundle, you can use `make unpack-secure` to unpack it here. If you haven't got a secure bundle to unpack, then run `make build-secure` to setup
volumes to mount to valet.

5. Setup your environment: `make build`

## Register a project

** Make sure you've added an .env file for your project first! **

`make register DIR=company/project AS=projectsite`

This will serve company/project/public as www.projectsite.test on the container. It will enforce SSL connections to www.projectsite.test.

This will then call `make register-workspace` from the directory selected, so your project can be setup for first run.

## Making a project available

`make launch DIR=company/project`

This will call `make launch-workspace` from the directory from the given directory. Generally this will just call `npm run watch`, but cache clear etc can be hooked in.

## Debugging

`make open DIR=company/project` to SSH into the container for general ubuntu access.
