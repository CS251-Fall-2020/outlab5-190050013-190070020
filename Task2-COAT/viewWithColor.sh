#!/bin/bash

outputA=$1;
cre_req=$2;
source ./resources/defineColors.sh;

declare -A background;
declare -A font;

IFS='';
count=0;
while read line;
do
  count=$(($count+1));
  if [[ $count == 1 || $count == 2 || $count == 3 ]]; then
    echo "$line";
  else
    read -r ans < <( grep "Basic Sciences" < <( echo "$line" ) );
    if [[ !( -z "$ans" ) ]]; then
      echo -e "$BLACK_BACKGROUND$CYAN_FONT$line$RESET_ALL";
    fi;
    read -r ans < <( grep "Engineering Science" < <( echo "$line" ) );
    if [[ !( -z "$ans" ) ]]; then
      echo -e "$GREEN_BACKGROUND$BLACK_FONT$line$RESET_ALL";
    fi;
    read -r ans < <( grep "HSS Elective" < <( echo "$line" ) );
    if [[ !( -z "$ans" ) ]]; then
      echo -e "$BLACK_BACKGROUND$GREEN_FONT$line$RESET_ALL";
    fi;
    read -r ans < <( grep "Institute Elective" < <( echo "$line" ) );
    if [[ !( -z "$ans" ) ]]; then
      echo -e "$WHITE_BACKGROUND$BLACK_FONT$line$RESET_ALL";
    fi;
    read -r ans < <( grep "Core course" < <( echo "$line" ) );
    if [[ !( -z "$ans" ) ]]; then
      echo -e "$CYAN_BACKGROUND$BLACK_FONT$line$RESET_ALL";
    fi;
    read -r ans < <( grep "Department elective" < <( echo "$line" ) );
    if [[ !( -z "$ans" ) ]]; then
      echo -e "$BLACK_BACKGROUND$YELLOW_FONT$line$RESET_ALL";
    fi;
    read -r ans < <( grep "Honors core" < <( echo "$line" ) );
    if [[ !( -z "$ans" ) ]]; then
      echo -e "$BLACK_BACKGROUND$WHITE_FONT$line$RESET_ALL";
    fi;
    read -r ans < <( grep "Minor" < <( echo "$line" ) );
    if [[ !( -z "$ans" ) ]]; then
      echo -e "$WHITE_BACKGROUND$MAGENTA_FONT$line$RESET_ALL";
    fi;
    read -r ans < <( grep "Additional Learning" < <( echo "$line" ) );
    if [[ !( -z "$ans" ) ]]; then
      echo -e "$WHITE_BACKGROUND$RED_FONT$line$RESET_ALL";
    fi;
  fi;
done < "$outputA";


exit 0;
