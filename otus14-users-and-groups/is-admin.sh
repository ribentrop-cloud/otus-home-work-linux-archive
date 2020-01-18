#!/bin/bash
echo "PAM_USER"$PAM_USER
if id -nG $PAM_USER | grep -qw "admin"; then
	echo "group admin"
	exit 0
else
	if [ $(date +%a) = "Sat" ] || [ $(date +%a) = "Sun" ]; then
		echo "Sa-Su other group"
		exit 1
	else
		echo "Mo-Fri all users"
		exit 0
	fi
fi
