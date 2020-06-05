
FROM ubuntu:18.04 



#RUN sed -i 's#http://archive.ubuntu.com/ubuntu/#mirror://mirrors.ubuntu.com/mirrors.txt#' /etc/apt/sources.list; 

RUN sed -i 's/archive.ubuntu.com/cn.archive.ubuntu.com/' /etc/apt/sources.list;

# built-in packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt update 

RUN  apt install -y build-essential
RUN  apt install -y curl supervisor sudo net-tools xz-utils
    
RUN apt install -y vim-gtk openssh-server git xfonts-scalable  

RUN apt install -y  screen tightvncserver autocutsel
RUN  apt install -y icewm

RUN apt install -y x11vnc xvfb

RUN cd /tmp \
	&& wget https://nodejs.org/dist/v12.13.0/node-v12.13.0-linux-x64.tar.xz \
	&& xz -d node-v12.13.0-linux-x64.tar.xz \
	&& tar xf node-v12.13.0-linux-x64.tar \
	&& mv node-v12.13.0-linux-x64 /usr/local/node

RUN cd /tmp \
	&& wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz \
	&& tar zxf go1.13.5.linux-amd64.tar.gz \
	&& mv go /usr/local/go

 
COPY startup.sh /
COPY supervisord.conf /
COPY x11vnc.sh /
CMD ["/startup.sh"]
