#!/bin/bash

output=$1;
Sem=$2;
Year=$3;
source ./resources/defineColors.sh;

awk -v cr=$cre_req -v bf=$BLACK_FONT -v rf=$RED_FONT -v gf=$GREEN_FONT -v yf=$YELLOW_FONT -v bef=$BLUE_FONT -v mf=$MAGENTA_FONT -v cf=$CYAN_FONT -v wf=$WHITE_FONT -v bb=$BLACK_BACKGROUND -v rb=$RED_BACKGROUND -v gb=$GREEN_BACKGROUND -v yb=$YELLOW_BACKGROUND -v beb=$BLUE_BACKGROUND -v mb=$MAGENTA_BACKGROUND -v cb=$CYAN_BACKGROUND -v wb=$WHITE_BACKGROUND -v n=$RESET_ALL -v sem=$Sem -v yr=$Year 'BEGIN{
	RS="\n";
	ORS="\n";
	Semester_col=0;
	Year_col=0;
	Code_col=0;
	FS="[[:space:]][[:space:]]+";
}
{
	if(FNR==2)
	{
		print $0;
		for(i=1; i<=NF; i++) {
			if($i=="Semester") {
				Semester_col=i;
			}
		else if($i=="Year") {
			Year_col = i;
		}
	else if($i=="Code") {
		Code_col = i;
	}
		}
	}
else if(FNR <= 3)
	{
		print $0;
	}
else {
		if($Semester_col==sem  && $Year_col==yr) {
			course_name[NR]=$Code_col;
			info[NR]=$0;
		}
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
			#print course_name[c];
			if(course_name[c] < min_str){
				#print min_str,c,course_name[c];
			min_str = course_name[c];
			record = c;
		}
	}
		#print "";
		#print min_str,record,"\n";
		print info[record];
		course_name[record] = "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
	}
}' FS="[[:space:]][[:space:]]+" $output;
