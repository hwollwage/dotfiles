#!/usr/bin/env bash

quotes=(
  "~ hi Oaklynn, ok troon ~"
  "~ just get bangs hon ~"
  "~ midwest emo sucks, but so do i ~"
  "~ twin size mattress ~"
  "~ /tttt/ ¿ ~"
  "~ your deep rest ~"
)

while true; do
  for quote in "${quotes[@]}"; do
    echo "$quote"
    sleep 30
  done
done
