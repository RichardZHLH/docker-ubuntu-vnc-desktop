#!/bin/bash



USER=ubuntu
HOME=/home/ubuntu
useradd --create-home --shell /bin/bash  --user-group --groups adm,sudo ubuntu
PASSWORD=wanglu
HOME=/home/ubuntu
echo "ubuntu:$PASSWORD" | chpasswd


# clearup
PASSWORD=
mkdir -p /run/sshd  # for sshd
rm -rf  /tmp/.X*-lock /tmp/.X11-unix/X*
sudo sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1 # for vscode
sudo -u ubuntu -H /usr/bin/vncserver
exec supervisord -n -c /supervisord.conf


