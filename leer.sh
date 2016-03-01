#!/bin/bash
for dir in decks/*.txt; do
DECK=$( echo "$dir" | sed "s/\.txt//g" | sed "s/decks\///g")
 	echo "revinculando deck :$DECK"
	while read  p; do
		#echo " revinculando : $p"
		USER=$( echo $p | awk '{printf $1}')
		PASSOWRD=$( echo $p | awk '{printf $2}')
		#echo $PASSOWRD
	        echo $DECK $USER $PASSOWRD
		./login.sh $DECK $USER $PASSOWRD
		 sleep $[ ( $RANDOM % 25 )  + 5 ]s
	done < $dir
   
done
