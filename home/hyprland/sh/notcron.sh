#!/usr/bin/env bash

# make sure we are the only one running
kill $(pgrep -f "bash /home/mark/.config/hypr/sh/notcron.sh" | grep -v $$)

function time_warn() { 
    while true; do
        barless time-warn
        sleep 60
    done 
};

function battery_warn() {
    sleep 30
    while true; do
        barless battery-warn
        sleep 60
    done
};

battery_warn &
time_warn &
