#!/bin/bash -x

echo "Welcome To Gambling Simulator"

WINNING_LIMIT=150
LOOSING_LIMIT=50
BET=1
stake=100

cashInHand=$stake
while [[ $cashInHand -lt $WINNING_LIMIT && $cashInHand -gt $LOOSING_LIMIT ]]
do
	if [ $((RANDOM%2)) -eq 1 ]
	then
		cashInHand=$(($cashInHand + $BET))
	else
		cashInHand=$(($cashInHand - $BET))
	fi
done

if [ $cashInHand -eq $WINNING_LIMIT ]
then
	echo "Gambler Won And Resign for the day"
else
	echo "Gambler Loose And Resign for the day"
fi
