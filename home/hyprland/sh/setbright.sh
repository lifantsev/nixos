#!/usr/bin/env bash

brightnessctl -e3 set "$1" &
sleep 0.01 # wait for brightnessctl to update brightness
