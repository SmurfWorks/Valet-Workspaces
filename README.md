## Setup project base

1. Get yourself a linux setup. If you're on windows, then install WSL.
2. Install docker for desktop
3. Install make on your unix system: `sudo apt install -y make`
4. Setup your environment: `make build`

5. If this is your primary development environment, additional steps may include installing wireguard or restoring SSH keys and mounting them in docker when applicable.

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
