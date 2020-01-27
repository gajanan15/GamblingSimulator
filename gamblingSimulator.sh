#!/bin/bash -x

echo "Welcome To Gambling Simulator"

BET=1
stake=100

if [ $((RANDOM%2)) -eq 1 ]
then
	stake=$(($stake + $BET))
else
	stake=$(($stake - $BET))
fi
