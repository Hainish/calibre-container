#!/bin/bash
vagrant ssh -- x11vnc -display :0 -bg
xtightvncviewer localhost &
