#!/bin/bash



USER=${USER:-root}
HOME=/root
if [ "$USER" != "root" ]; then
    echo "* enable custom user: $USER"
    if [ -z "$UID" ]; then
	    UID="1001"
    fi
    useradd --create-home --shell /bin/bash --uid $UID --user-group --groups adm,sudo $USER
    if [ -z "$PASSWORD" ]; then
        echo "  set default password to \"ubuntu\""
        PASSWORD=ubuntu
    fi
    HOME=/home/$USER
    echo "$USER:$PASSWORD" | chpasswd
fi
sed -i -e "s|%USER%|$USER|" -e "s|%HOME%|$HOME|" /supervisord.conf


# clearup
PASSWORD=
mkdir -p /run/sshd  # for sshd
rm -rf  /tmp/.X*-lock /tmp/.X11-unix/X*
sudo sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1 # for vscode
exec supervisord -n -c /supervisord.conf
