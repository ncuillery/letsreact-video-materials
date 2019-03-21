#!/bin/bash

MONTH="201903"
BEGIN="24:44"
DURATION="56:10" # Use https://www.calculator.net/time-calculator.html to compute duration
VIDEO_RES="1856x864"

rm -rf ./temp
mkdir -p ./temp

# Resize the splash image (video is not always 1920x1080)
convert ./$MONTH/splash.png -resize $VIDEO_RES\! ./temp/splash.png

# Cut the video
ffmpeg -ss $BEGIN -i ./$MONTH/input.mp4 -to $DURATION -c copy ./temp/temp.mp4

# Add the splashscreen
# https://stackoverflow.com/a/24111474/769006
ffmpeg -loop 1 -framerate 25 -t 10 -i ./temp/splash.png \
       -t 10 -f lavfi -i aevalsrc=0 \
       -i ./temp/temp.mp4 \
       -filter_complex '[0:0] [1:0] [2:0] [2:1] concat=n=2:v=1:a=1' \
       ./$MONTH/video.mp4

