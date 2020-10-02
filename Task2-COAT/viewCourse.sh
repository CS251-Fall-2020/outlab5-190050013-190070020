#!/bin/bash

output=$1;
sub_code="$2";

awk -v cdsb="$sub_code" 'BEGIN{
	RS="\n";
	ORS="\n";
	Code_col=0;
	FS="[[:space:]][[:space:]]+";
}
{
	if(FNR==2)
	{
		print $0;
		for(i=1; i<=NF; i++) {
	     if($i=="Code") {
		       Code_col = i;
           break;
	        }
        }
      }
else if(FNR <= 3)
	{
		print $0;
	}
else {
		if($Code_col ~ cdsb)
    course_name[NR]=$Code_col;
    info[NR]=$0;
		}
}
END {
	count = 0;
	for(c in  course_name){
		count++;
	}
	for (i=0;i<count;i++) {
		min_str  = "ZZZZZZZZZZZZZZZZ";
		record = -1;
		for(c in  course_name){
			if(course_name[c] < min_str){
			min_str = course_name[c];
			record = c;
		}
	}
		print info[record];
		course_name[record] = "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
	}
}' FS="[[:space:]][[:space:]]+" $output;

exit 0;
