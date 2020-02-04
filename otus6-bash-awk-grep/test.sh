names="a
b
c"
echo "$names"
SAVEIFS=$IFS   # Save current IFS
IFS=$'\n'      # Change IFS to new line
names_arr=($names) # split to array $names
IFS=$SAVEIFS   # Restore IFS

echo "${names_arr[1]}"
