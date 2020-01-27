#!/bin/bash -x

echo "Welcome To Gambling Simulator"

#constant
WINNING_LIMIT=150
LOOSING_LIMIT=50
BET=1

#variable
stake=100
cashInHand=$stake
winningAmount=0
loosingAmount=0

for((i=1;i<=20;i++))
do
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
		winningAmount=$(($winningAmount+50))
		cashInHand=$stake
	else
		loosingAmount=$(($loosingAmount+50))
		cashInHand=$stake
	fi
done
if [ $winningAmount -gt $loosingAmount ]
then
	echo "You Won by $(($winningAmount - $loosingAmount)) in 20 days"
elif [ $winningAmount -lt $loosingAmount ]
then
	echo "You lost by $(($loosingAmount - $winningAmount)) in 20 days"
else
	echo "neither won nor lost"
fi
