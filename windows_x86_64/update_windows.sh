#!/bin/bash

# workaround issue https://github.com/hashicorp/vagrant/issues/13193

ip_address=$(vagrant winrm-config | grep 'HostName' | head -1 | awk '{print $2}')

# WinRM lib doesn't honor no_proxy
unset HTTP_PROXY HTTPS_PROXY http_proxy https_proxy

ansible-playbook -i "${ip_address}," \
    -e ansible_connection=winrm \
    -e ansible_port=5985 \
    -e ansible_winrm_transport=basic \
    -e ansible_winrm_scheme=http \
    -e ansible_shell_type=powershell \
    -e ansible_user=vagrant \
    -e ansible_password=vagrant \
    update_windows.yml $*
