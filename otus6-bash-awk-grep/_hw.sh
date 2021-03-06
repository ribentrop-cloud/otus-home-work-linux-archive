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

make_ip_arrays()
{
# read file line by line
while IFS= read -r line; do

  # get log record time
  log_time="$(echo $line | awk '{print $4}')"
  log_time="$(echo $log_time | cut -b 2-21)"
  # попробовать через {...1:-1q}
  log_time="$(date -d "$(echo $log_time | sed -e 's,/,-,g' -e 's,:, ,')" +"%s")"
  if [[ log_time -gt $CHECKPOINT_LOWER ]] && [[ log_time -lt $CHECKPOINT_UPPER ]]; then
    echo " ... let's get IP ..."
    echo $log_time
  
    # extract source IP
    ip_addr_src="$(echo $line | awk '{print $1}')"
    ip_addr_src_arr+=($ip_addr_src)
    ip_addr_src_string="${ip_addr_src_string} ${ip_addr_src}"

    # extract destination IP
    ip_addr_dst="$(echo $line | sed -E 's/.+\s//')"
    ip_addr_dst_arr+=($ip_addr_dst)
  fi

done < apache.log
}

make_csv_from_array()
{
  SAVEIFS=$IFS
  IFS=$'\n'
  ip_addr_sorted_str=($1)
  IFS=$SAVEIFS

  for elem in "${ip_addr_sorted_str[@]}"
  do
    ip="$(echo "$elem" | awk '{print $2}')"
    count="$(echo "$elem" | awk '{print $1}')"
    echo "$ip,$count"
  done
}

determine_checkpoint
make_ip_arrays

echo "--- src csv ---"
ip_addr_src_sorted_str="$(echo "${ip_addr_src_arr[@]}" | tr ' ' '\n' | uniq -c  | sort -bgr)"
make_csv_from_array "$ip_addr_src_sorted_str"

echo "--- dst csv ---"
ip_addr_src_sorted_dst="$(echo "${ip_addr_dst_arr[@]}" | tr ' ' '\n' | uniq -c  | sort -bgr)"
make_csv_from_array "$ip_addr_src_sorted_dst"

