#!/bin/bash
echo "Welcome To Gambling Simulator"

#constant
WINNING_LIMIT=150
LOOSING_LIMIT=50
NUMBER_OF_DAYS=20
BET=1

#variable
stake=100
cashInHand=$stake
winningAmount=0
loosingAmount=0
wonCount=0
lostCount=0
currentAmount=0

#Dictionary
declare -A amountPerDay

function playGame() {
	for((i=1;i<=$NUMBER_OF_DAYS;i++))
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
			winningAmount=$(($winningAmount + 50))
			cashInHand=$stake
			((wonCount++))
			currentAmount=$(($currentAmount + 50))
		else
			loosingAmount=$(($loosingAmount + 50))
			cashInHand=$stake
			((lostCount++))
			currentAmount=$(($currentAmount - 50))
		fi
		amountPerDay[$i]=$currentAmount
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

	echo "Number of days won : $wonCount"
	echo "Number Of Days lost : $lostCount"
	echo "Total Amount won : $winningAmount"
	echo "Total Amount lost : $loosingAmount"
}

function checkLuck() {
	for i in ${!amountPerDay[@]}
	do
		echo "$i ${amountPerDay[$i]}"
	done | sort -k2 $1 | head -1
}

while [ $currentAmount -ge 0 ]
do
	playGame
	echo "Luckiest Day : "
	checkLuck -rn
	echo "Unluckiest Day : "
	checkLuck -n
	if [ ${amountPerDay[20]} -ge 0 ]
	then
		read -p "do you want to continue for next month(y/n): " result
		if [ $result == "y" ]
		then
			echo "next month"
			winningAmount=0
			loosingAmount=0
			wonCount=0
			lostCount=0
		else
			break
		fi
	fi
done
