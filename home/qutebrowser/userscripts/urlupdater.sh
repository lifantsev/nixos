#!/usr/bin/env bash

# NOTE this needs to be started at some point
# since i dont know of a way to autostart something in qutebrowser,
# it is started in the get-url function of custom-pkgs/browser.nix

# exit if urlupdater is already running
if ps aux | grep -v $$ | grep -q 'bash [^ ]*qutebrowser/userscripts/urlupdater.sh'; then
    exit
fi

while true; do
    qutebrowser ":spawn --userscript geturl.sh" # blocks for ~0.4s, writes to /tmp/qute_url
done
