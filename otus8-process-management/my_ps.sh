#!/bin/sh

# get numeric proc subdirs
proc_dir_list="$(ls  /proc | grep -o '[0-9]*')"

# convert string to array (with alternatives)
proc_dir_list_arr=($proc_dir_list)
#IFS=' ' read -r -a proc_dir_list_arr <<< "$proc_dir_list"

# iterate over subfolders and ...
for PID in "${proc_dir_list_arr[@]}"
do

  # ... get TTY

  # ... get STAT
  STAT="$(cat /proc/$PID/stat | awk -F ' ' '{print $3}')"

  # ... get TIME
  utime="$(cat /proc/$PID/stat | awk -F ' ' '{print $14}')"
  stime="$(cat /proc/$PID/stat | awk -F ' ' '{print $15}')"
  total_time=$(((utime+stime)/100))
  time_min=$(((total_time)/60))
  time_sec=$((total_time-time_min*60))
  TIME=$time_min:$time_sec

  # ... get CMD
  CMD="$(cat /proc/$PID/cmdline)"
  echo -e $PID' \t '$STAT' \t '$TIME' \t '$CMD

done
