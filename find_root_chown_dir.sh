#!/usr/bin/env bash
#Find chown root directory

find . -maxdepth 2 -type d | xargs ls -ld | grep root | grep "$1"
