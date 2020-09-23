#!/bin/bash

act=$1;
lgn=$2;
sem=$3;
year=$4;

awk -v s=$sem -v y=$year 'BEGIN{
	FS=",";
	RS="\r\n";
	ORS="\r\n";
	total_credits=0;
	numerator=0;
	credits_col=0;
	grade_col=0;
}
{
	if(NR==FNR && NR>1) {
		number[$1] = $2
	}
	else if(NR!=FNR && FNR==1) {
		for(i=1; i<=NF; i++) {
			if($i=="Credits") {
				credits_col=i;
			}
			else if($i=="letterGrade") {
				grade_col=i;
			}
		}
	}
	else if(FNR!=1) {
		if($1==y && $2==s) {
			total_credits += $credits_col;
			numerator += number[$grade_col]*$credits_col;
		}
	}
}
END {
	if(total_credits==0) printf("0.0000\n");
	else printf("%0.4f\n",numerator/total_credits);
}' $2 $1;