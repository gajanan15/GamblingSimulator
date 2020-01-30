#!/bin/bash
echo "Welcome To Gambling Simulator"

#constant
PERCENTAGE=50
STAKE=100
WINNING_LIMIT=$(($(($PERCENTAGE*$STAKE/100)) + $STAKE))
LOOSING_LIMIT=$(($STAKE-$(($PERCENTAGE*$STAKE/100))))
NUMBER_OF_DAYS=20
BET=1

#variable
cashInHand=$STAKE
winningAmount=0
loosingAmount=0
wonCount=0
lostCount=0
currentAmount=0

#Dictionary
declare -A amountPerDay
declare -A winOrLooseDictionary

function bet() {
	if [ $((RANDOM%2)) -eq 1 ]
	then
		cashInHand=$(($cashInHand + $BET))
	else
		cashInHand=$(($cashInHand - $BET))
	fi
}

function winOrLoose() {
	if [[ $cashInHand -eq $WINNING_LIMIT ]]
	then
		winningAmount=$(($winningAmount + $PERCENTAGE))
		cashInHand=$STAKE
		((wonCount++))
		currentAmount=$(($currentAmount + $PERCENTAGE))
		winOrLooseDictionary[$1]="Won"
	else
		loosingAmount=$(($loosingAmount + $PERCENTAGE))
		cashInHand=$STAKE
		((lostCount++))
		currentAmount=$(($currentAmount - $PERCENTAGE))
		winOrLooseDictionary[$1]="Lost"
	fi
}

function playGame() {
	for((i=1;i<=$NUMBER_OF_DAYS;i++))
	do
		while [[ $cashInHand -lt $WINNING_LIMIT && $cashInHand -gt $LOOSING_LIMIT ]]
		do
			bet
		done
		winOrLoose $i
		amountPerDay[$i]=$currentAmount
	done
	if [ $winningAmount -gt $loosingAmount ]
	then
		echo "Total Amount Win in 20 Days : $(($winningAmount - $loosingAmount))"
	elif [ $winningAmount -lt $loosingAmount ]
	then
		echo "Total Amount lost in 20 Days : $(($loosingAmount - $winningAmount))"
	else
		echo "neither won nor lost"
	fi

	echo "Number of days won : $wonCount"
	echo "Number Of Days lost : $lostCount"
	echo "Total Amount won : $winningAmount"
	echo "Total Amount lost : $loosingAmount"
	echo "Keys          : ${!amountPerDay[@]}"
	echo "Amount Per Day: ${amountPerDay[@]}"
	echo
	echo "keys                    : ${!winOrLooseDictionary[@]}"
	echo "Resign With Won Or Lost : ${winOrLooseDictionary[@]}"
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
	differenceOfWonOrLostAmount=$(($wonCount*$PERCENTAGE - $lostCount*$PERCENTAGE))
	if [ $differenceOfWonOrLostAmount -ge 0 ]
	then
		read -p "do you want to continue for next month(y/n): " result
		if [ $result == "y" ]
		then
			echo "next month"
			winningAmount=0
			loosingAmount=0
			wonCount=0
			lostCount=0
			currentAmount=0
		else
			break
		fi
	fi
done
