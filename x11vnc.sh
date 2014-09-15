#!/bin/bash
vagrant ssh -- x11vnc -display :0 -bg
DISPLAY=:0.0 xtightvncviewer localhost &
