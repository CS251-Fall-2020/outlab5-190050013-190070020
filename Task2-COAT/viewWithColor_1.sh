#!/bin/bash

outputA=$1;
cre_req=$2;
source ./resources/defineColors.sh;

awk -v cr=$cre_req -v bf=$BLACK_FONT -v rf=$RED_FONT -v gf=$GREEN_FONT -v yf=$YELLOW_FONT -v bef=$BLUE_FONT -v mf=$MAGENTA_FONT -v cf=$CYAN_FONT -v wf=$WHITE_FONT -v bb=$BLACK_BACKGROUND -v rb=$RED_BACKGROUND -v gb=$GREEN_BACKGROUND -v yb=$YELLOW_BACKGROUND -v beb=$BLUE_BACKGROUND -v mb=$MAGENTA_BACKGROUND -v cb=$CYAN_BACKGROUND -v wb=$WHITE_BACKGROUND -v n=$RESET_ALL 'BEGIN{
	RS="\r\n";
	ORS="\n";
	Tag_col=0;
}
function getfont(tag) { 
	if(font[tag]=="CYAN") return cf;
	if(font[tag]=="BLACK") return bf;
	if(font[tag]=="GREEN") return gf;
	if(font[tag]=="YELLOW") return yf;
	if(font[tag]=="WHITE") return wf;
	if(font[tag]=="MAGENTA") return mf;
   	if(font[tag]=="RED") return rf;
   	if(font[tag]=="BLUE") return bef;
}
function getback(tag) { 
	if(back[tag]=="CYAN") return cb;
	if(back[tag]=="BLACK") return bb;
	if(back[tag]=="GREEN") return gb;
	if(back[tag]=="YELLOW") return yb;
	if(back[tag]=="WHITE") return wb;
	if(back[tag]=="MAGENTA") return mb;
   	if(back[tag]=="RED") return rb;
   	if(back[tag]=="BLUE") return beb;
}
{	
	if(NR==FNR && FNR!=1) {
		font[$1]=$3;
		back[$1]=$4;
	}
	if(NR!=FNR && FNR>=1 && FNR<=3) {
		print $0;
		if(FNR==2) {
			for(i=1; i<=NF; i++) {
				if($i=="Tag") {
					Tag_col=i;
					break;
				}
			}
		}
	}
	else if(NR!=FNR) {
		for(tag in font){
			if ($0~tag){print getback(tag) getfont(tag) $0 n }
		}
	}
}' FS="," $cre_req FS="[[:space:]][[:space:]]+" $outputA
