#!/bin/bash

echo "fs.file-max = 1024000" >> /etc/sysctl.conf
sysctl -p
echo -e "root soft nofile 512000 \nroot hard nofile 1024000" >> /etc/security/limits.conf
reboot
