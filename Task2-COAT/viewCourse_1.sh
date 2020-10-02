#!/bin/bash

output=$1;
string=$2;
declare -a arr;
for i in "$@"
do
    arr+=("$i")
done
awk -v s="${arr[1]}" 'BEGIN{
	RS="\n";
	ORS="\n";
}
{	
	if(NR<=3) {print "CS 101" $0;}
	if(NR>3 && $0~s) {print  $4 $0 | "sort -k 1"}
}' FS="[[:space:]][[:space:]]+" "${arr[0]}" | cut -c 7-