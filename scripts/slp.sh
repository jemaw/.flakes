#!/bin/bash
MIN_TO_SLEEP=${1:-0}    
sleep "${MIN_TO_SLEEP}"m
i3lock
sleep 1
systemctl suspend
