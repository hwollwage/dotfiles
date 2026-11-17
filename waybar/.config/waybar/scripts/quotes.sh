#!/usr/bin/env bash

quotes=(
  "~ hi Oaklynn, ok troon ~"
  "~ just get bangs hon ~"
  "~ midwest emo sucks, but so do i ~"
)

while true; do
  for quote in "${quotes[@]}"; do
    echo "$quote"
    sleep 30
  done
done
