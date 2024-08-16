#!/bin/bash

# xhost +local:root

# in case of error: "cannot open display: :0" or "cannot open display: :1" with VcXsrv host
# try to set the display manually by using your own local ip address
# export DISPLAY=172.18.96.1:0.0

cd scripts

python3 main.py --no-sandbox
