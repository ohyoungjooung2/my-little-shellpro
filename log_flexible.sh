#!/usr/bin/env bash
#Seven days in seconds.
seven_days=$((7*24*60*60))
#Today's date in seconds
today_present=$(date +%s)
#Calculate seven days
seven_days_before=$(($today_present-$seven_days))
echo "Seven day in seconds is $seven_days_before"
#Seven days seconds into Y-m-d-HM format
seven_days_before_in_yhmhs=$(date -d @$seven_days_before "+%Y%m%d%H%M")
echo "sevenn days before in yhmhs is $seven_days_before_in_yhmhs"

#find ./ -type f | awk -F'.' '{ print $5}'
#Revmoign seven days before logs
find ./ -type f -name "*.log" | awk -v sdby="$seven_days_before_in_yhmhs" -F'.' '{if ($5 < sdby) print $0}' | xargs rm -fv
exit 0
