#!/bin/bash

rm -rf ./temp
mkdir -p ./temp

# Gradient background
convert -size 1920x830 canvas:black ./temp/background1.png
convert -size 1920x50 gradient:black ./temp/background2.png
convert -size 960x200 canvas:white ./temp/background3.png

# Date
convert -background black -bordercolor black -border 50x50 -fill white -pointsize 72 label:"$MEETUP" ./temp/date.png

# Logo
convert ./letsreact.png -resize 400x400 ./temp/letsreact.png

# Title
convert -background black -gravity center -fill white -pointsize 72 label:"$SPEAKER" ./temp/speaker.png
convert -background black -gravity center -fill white -pointsize 48 label:"$TALK" ./temp/talk.png 
convert ./temp/speaker.png ./temp/talk.png -gravity center -append ./temp/title.png

# Sponsor
convert -fill black -pointsize 72 label:"Host:  " ./temp/host_label.png
convert ./$MONTH/host.png -resize x100 ./temp/host_logo.png
convert ./temp/host_label.png ./temp/host_logo.png -gravity center +append ./temp/host.png
composite -gravity center ./temp/host.png ./temp/background3.png ./temp/host.png

convert -fill black -pointsize 72 label:"Sponsor:  " ./temp/sponsor_label.png
convert ./$MONTH/sponsor.png -resize x100 ./temp/sponsor_logo.png
convert ./temp/sponsor_label.png ./temp/sponsor_logo.png -gravity center +append ./temp/sponsor.png
composite -gravity center ./temp/sponsor.png ./temp/background3.png ./temp/sponsor.png

convert ./temp/host.png ./temp/sponsor.png +append ./temp/footer.png

# Assembly
convert ./temp/background1.png ./temp/background2.png ./temp/footer.png -append ./temp/background.png
composite -gravity northeast ./temp/date.png ./temp/background.png ./$MONTH/splash.png
composite -gravity northwest ./temp/letsreact.png ./$MONTH/splash.png ./$MONTH/splash.png
composite -gravity center ./temp/title.png ./$MONTH/splash.png ./$MONTH/splash.png

