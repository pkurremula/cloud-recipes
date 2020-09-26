#!/usr/bin/env bash

# Generate a SSH key pair

declare -r ssh_file='id-rsa-bastion'
declare -r identity='terraform'

# Assign a passcode ie. `-P "my-passcode"` if you using this for production.
ssh-keygen -b 4096 -t rsa -P "" -C "${identity}" -f "${ssh_file}"
