#!/usr/bin/env bash

if [ "$1" == "mute" ]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
else
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "$1" -l 1.5
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
fi
