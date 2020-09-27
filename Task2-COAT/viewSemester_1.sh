#!/bin/bash

output=$1;
sem=$2;
year=$3;

awk -v s=$sem -v y=$year 'BEGIN{
	RS="\n";
	ORS="\n";
}
{	
	if(NR<=3) {print "CS 101" $0;}
	if(NR>3 && $0~s && $0~y) {print  $4 $0 | "sort -k 1"}
}' FS="[[:space:]][[:space:]]+" $1 | cut -c 7-