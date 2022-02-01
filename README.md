## What is this project?

Sometimes running multiple projects on valet is easy, but other times you need to complete multiple actions as part of your setup. SSH keys, database builds, php and node version configuration, etc

The idea is that a workspace is a fresh slate you can come back to you in a simple command run where all of that stuff is done, so you can get back to app dev as quick as possible.

## Setup project base

1. Get yourself a linux setup. If you're on windows, then install WSL. Make sure it has git to get this repo.

2. Install docker for desktop - make sure this is running at start up so that your terminal has access to the docker commands via the make file.

3. Install some tools for valet workspaces: `sudo apt install -y make zip`

4. Optionally pull in your SSH keys and configurations, and VPN configurations. If you're pulling in a packed secure bundle, you can use `make secure-unpack` to unpack it here. If you haven't got a secure bundle to unpack, then run `make secure-build` to setup
volumes to mount to valet.

5. Setup your environment: `make build`

6. Extra software:

    - VSCode (set your line endings to LF if you're on Windows)
    - DBeaver (Free DB utility with SSH tunnelling)
    - Wireguard (in combination with ALGOVPN)

## Register a project

** Make sure you've added an .env file for your project first! **

`make register DIR=company/project AS=projectsite`

This will serve company/project/public as www.projectsite.test on the container. It will enforce SSL connections to www.projectsite.test.

This will then call `make register-workspace` from the directory selected, so your project can be setup for first run.

## Making a project available

`make launch DIR=company/project`

This will call `make launch-workspace` from the directory from the given directory. Generally this will just call `npm run watch`, but cache clear etc can be hooked in to the project specifically. 

This will also run the open command to the given directory, so you can run artisan commands etc.

## Debugging

`make open DIR=company/project` to SSH into the container for general ubuntu access.
