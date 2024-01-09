#!/bin/bash

function load-wallpaper() {
  local active-wallpaper="$(< "${HOME}/.wallpaper")"
    if [ -f "$active-wallpaper" ]; then
      swaybg -i "$active-wallpaper"
    fi
}

load-wallpaper