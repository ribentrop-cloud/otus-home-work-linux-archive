#!/bin/sh
# read file line by line
ip_addr_arr=()
while IFS= read -r line; do
  #echo "Text read from file: $line"
  # extract IP
  ip_addr="$(echo $line | awk '{print $1}')"
  ip_addr_arr+=($ip_addr)
  echo $ip_addr
done < apache.log
ip_addr_arr+=('bbb')

echo -e "$ip_addr_arr\n"

# --- print IP array ---
for each in "${ip_addr_arr[@]}"
do
  echo "$each"
done
