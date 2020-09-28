#!/usr/bin/env bash

declare log_file='/var/log/user-data.log|logger'

%{ if enable_log == true ~}
set -x
exec > >(tee $${log_file} -t user-data) 2>&1
%{ endif ~}

%{ for url in websites ~}
curl ${url}:${port}
%{ endfor ~}
