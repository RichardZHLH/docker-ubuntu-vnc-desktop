#!/bin/bash

if [ -f $HOME/.vnc/passwd ]; then
	x11vnc -display :1 -xkb -forever -shared -repeat  -rfbauth $HOME/.vnc/passwd
else
	x11vnc -display :1 -xkb -forever -shared -repeat
fi
