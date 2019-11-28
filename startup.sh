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

exec supervisord -n -c /supervisord.conf
