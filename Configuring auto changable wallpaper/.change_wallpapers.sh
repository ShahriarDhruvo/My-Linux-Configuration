#!/bin/bash
# script to set random background wallpapers on my GNOME desktop
# set base path
export wallpaper_path=/home/sed/Pictures/Wallpapers
shopt -s nullglob
# store all the image file names in wallpapers array
wallpapers=(
    $wallpaper_path/*.jpg
    $wallpaper_path/*.jpeg
    $wallpaper_path/*.png
    $wallpaper_path/*.bmp
    $wallpaper_path/*.svg
)
# get array size
wallpapers_size=${#wallpapers[*]}

# set random wallpapers
# loop infinitely
while true
do
    # generate random index
    random_index=$(($RANDOM % $wallpapers_size))
    # then set a random wallpaper
    gsettings set org.gnome.desktop.background picture-uri ${wallpapers[$random_index]}
    # keep the wallpaper for the specified time
    sleep 15m
done
