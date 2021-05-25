#!/bin/bash

inkscape -w 16 -h 16 -o favicon-16x16.png favicon-master.svg
inkscape -w 32 -h 32 -o favicon-32x32.png favicon-master.svg
inkscape -w 48 -h 48 -o favicon-48x48.png favicon-master.svg
convert favicon-16x16.png favicon-32x32.png favicon-48x48.png favicon.ico

inkscape -w 192 -h 192 -o android-chrome-192x192.png favicon-master.svg
inkscape -w 512 -h 512 -o android-chrome-512x512.png favicon-master.svg
inkscape -w 180 -h 180 -o apple-touch-icon.png favicon-master.svg
