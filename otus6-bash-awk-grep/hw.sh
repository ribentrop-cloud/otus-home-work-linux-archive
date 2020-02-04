#!/bin/sh

ip_addr_arr_src=()
ip_addr_arr_dst=()
ip_addr_src_string=
ip_addr_sdt_string=
NEWLINE=$'\n'

determine_checkpoint()
{
  CHECKPOINT_UPPER=1478863420
  CHECKPOINT_LOWER=1478811700
}

make_ip_array()
{
# read file line by line
while IFS= read -r line; do

  # get log record time
  log_time="$(echo $line | awk '{print $4}')"
  log_time="$(echo $log_time | cut -b 2-21)"
  log_time="$(date -d "$(echo $log_time | sed -e 's,/,-,g' -e 's,:, ,')" +"%s")"
  if [[ log_time -gt $CHECKPOINT_LOWER ]] && [[ log_time -lt $CHECKPOINT_UPPER ]]; then
    echo " ... let's get IP ..."
    echo $log_time
  
    # extract source IP
    ip_addr_src="$(echo $line | awk '{print $1}')"
    ip_addr_src_arr+=($ip_addr_src)
    ip_addr_src_string="${ip_addr_src_string} ${ip_addr_src}"
    #echo $ip_addr_src_string" <-"

    # extract destination IP
    # ??? переделать через SED
    ip_addr_dst="$(echo $line | sed -E 's/.+\s//')"
    ip_addr_dst_arr+=($ip_addr_dst)
  fi

done < apache.log
}

print_ip_src_array()
{
  echo "print_ip_src_array : "
  for each in "${ip_addr_src_arr[@]}"
  do
    echo "$each"
  done
}

print_ip_dst_array()
{
  echo "print_ip_dst_array : "
  for each in "${ip_addr_dst_arr[@]}"
  do
    echo "$each"
  done
}

amake_csv_from_array()
{
  echo $1
}

determine_checkpoint
make_ip_array
#print_ip_src_array
#print_ip_dst_array
#echo  -e $ip_addr_src_string | uniq -c | sort -bgr
# make array from 
ip_addr_src_arr_sorted="$(echo "${ip_addr_src_arr[@]}" | tr ' ' '\n' | uniq -c  | sort -bgr)"
#echo "${ip_addr_src_arr[@]}" | tr ' ' '\n' | uniq -c  | sort -bgr"
echo "-- final ---"
IFS=$'\n' read -r -a array <<< "$ip_addr_src_arr_sorted"
echo $array

for each in "${array[@]}"
  do
    echo "$each"
  done


#make_csv_from_array "$ip_addr_src_arr_sorted"

