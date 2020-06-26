#!/bin/bash

sudo apt install tftpd-hpa -y
sudo mkdir /tftpboot
sudo chown -R tftp:tftp /tftpboot
sudo chmod 2755 /tftpboot

exit