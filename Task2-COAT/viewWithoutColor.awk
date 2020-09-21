#!/usr/bin/awk -f

BEGIN {
	FS=",";
	RS="\r\n";
	ORS="\r\n"
	name_col = 0;
	num_cols = 0;	
}
{
	if (NR==1) {
		for (i=0; i<NF; i++) {
			if($i=="Name") {
				name_col = i;
				break;
			}
		}
		if (name_col==0) {
			num_cols=NF;
		}
		else {
			num_cols=NF-1;
		}
		for (i=0; i<num_cols*20; i++) {
			printf("-");
		}
		printf("\n");
		for (i=1; i<=NF; i++) {
			if(i!=name_col) {
				printf("%20s",$i);
			}
		}
		printf("\n");
		for (i=0; i<num_cols*20; i++) {
			printf("-");
		}
		printf("\n")
	}
	else {
		for (i=1; i<=NF; i++) {
			if(i!=name_col) {
				printf("%20s",$i);
			}
		}
		printf("\n");
	}
}