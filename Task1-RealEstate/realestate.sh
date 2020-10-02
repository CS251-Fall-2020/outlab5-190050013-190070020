#!/bin/bash

if [ "$#" -ne 3 ]; then
	echo "Usage: ./realestate.sh <file1> <file2> <file3>"
	exit 1
else
	file1="$1";
	file2="$2";
	file3="$3";
	income="200";
	awk -F "," 'BEGIN {RS="\n";} {
		rent=0;
		rate=$4;
		for (i=0; i<$3; i++) {
			rent=rent+12*int(0.9*$2*rate);
			rate=int(rate*(1+$5/100));
		}
		income=rent - 12*$3*$6;
		print $1,income,$3
		}' ORS="\n" OFS="," "$file1" | sort -t',' -k2,2nr -k3,3n > "$file2"
	awk -F "," '{print $1}' "$file2" > "$file3"
fi
exit 0