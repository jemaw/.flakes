#!/bin/bash
scrot -o -s /tmp/scrot.png
xclip -selection c -t image/png < /tmp/scrot.png
