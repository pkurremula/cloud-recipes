#!/bin/bash

declare cronfile='/tmp/cron'

# Keep system up to date with security patches twice daily.
cat > "$${cronfile}" << EOF
0 0,12 * * * yum -y update --security
EOF
crontab "$${cronfile}"
rm "$${cronfile}"

# Use custom tcp port for ssh.
sed -i 's/.*Port .*/Port ${bastion_port}/g' /etc/ssh/sshd_config

# Disable X11 forwarding
sed -i 's/.*X11Forwarding .*/X11Forwarding no/g' /etc/ssh/sshd_config
