
FROM ubuntu:18.04 



RUN sed -i 's#http://archive.ubuntu.com/ubuntu/#mirror://mirrors.ubuntu.com/mirrors.txt#' /etc/apt/sources.list; 


# built-in packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt update \
    && apt install -y  software-properties-common curl apache2-utils \
    && apt install -y  --allow-unauthenticated \
        supervisor sudo net-tools zenity xz-utils \
        dbus-x11 x11-utils \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*


RUN apt update \
    && apt install -y  --allow-unauthenticated \
	xvfb x11vnc \
        lxde gtk2-engines-murrine gnome-themes-standard gtk2-engines-pixbuf gtk2-engines-murrine arc-theme \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*
RUN apt update \
    && apt install -y vim-gtk openssh-server git xfonts-scalable  \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
	&& wget https://nodejs.org/dist/v12.13.0/node-v12.13.0-linux-x64.tar.xz \
	&& xz -d node-v12.13.0-linux-x64.tar.xz \
	&& tar xf node-v12.13.0-linux-x64.tar \
	&& mv node-v12.13.0-linux-x64 /usr/local/node

RUN cd /tmp \
	&& wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz \
	&& tar zxf go1.13.5.linux-amd64.tar.gz \
	&& mv go /usr/local/go

RUN apt update \
    && apt install -y  build-essential screen tightvncserver autocutsel language-pack-en  \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i 'X11UseLocalhost/a\X11UseLocalhost no' /etc/ssh/sshd_config
 
RUN apt update \
    && apt install -y  wine64  \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*
 
COPY startup.sh /
COPY supervisord.conf /
COPY x11vnc.sh /
CMD ["/startup.sh"]
