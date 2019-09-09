#!/usr/bin/env bash

# 
# Выполнить из консоли (не билдом сублайма).
# 

set -eu

cd "$(dirname "${0}")"

mkdir -p ../jpg

find ../jpg -type f -delete
find ../jpg -type d -not -path ../jpg | xargs -I {} rm -rf {}

sources=(
  'beautiful-beauty.jpg'
  'blooming-flora.jpg'
  'classic-car.jpg'
  'colorful-autumn.jpg'
  'headlights-lamborghini.jpg'
  'natural-nature.jpg'
  'redhead-girl.jpg'
  'ripe-apple.jpg'
)

formats=(
  '2048-2048'
  '800-800'
  '640-640'
  '320-320'
  '300-300'
  '200-200'
  '100-100'
  '64-64'
  '48-48'
  '32-32'
  '16-16'
  '1920-1080'
  '1280-720'
  '854-480'
  '1080-1920'
  '480-854'
  '720-1280'
  '2048-1536'
  '1600-1200'
  '1400-1050'
  '1280-960'
  '1152-864'
  '1024-768'
  '800-600'
  '768-576'
  '640-480'
  '320-240'
  '1536-2048'
  '1200-1600'
  '1050-1400'
  '960-1280'
  '864-1152'
  '768-1024'
  '600-800'
  '576-768'
  '480-640'
  '240-320'
)

for source_index in ${!sources[@]}
do
  source=${sources[$source_index]}
  for format_index in ${!formats[@]}
  do
    format=${formats[$format_index]}
    wget "https://webdav.yandex.ru/images/jpg/${format}-${source}" --user=Zlatov --password=$YANDEX_PASSWORD -P ../jpg
  done
done
