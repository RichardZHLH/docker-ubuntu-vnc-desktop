
FROM ubuntu:18.04 



RUN sed -i 's#http://archive.ubuntu.com/ubuntu/#mirror://mirrors.ubuntu.com/mirrors.txt#' /etc/apt/sources.list; 

# built-in packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt update 

RUN apt install -y build-essential
RUN apt install -y curl supervisor sudo net-tools xz-utils
    
RUN apt install -y vim-gtk openssh-server git xfonts-scalable  

RUN apt install -y  screen tightvncserver autocutsel

RUN apt install -y x11vnc xvfb
RUN apt install -y cinnamon
 
COPY startup.sh /
COPY supervisord.conf /
COPY x11vnc.sh /
CMD ["/startup.sh"]
