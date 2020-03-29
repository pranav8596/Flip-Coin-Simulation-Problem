#!/bin/bash -x

#Constants
SINGLET=1

#Declaration of a Dictionary
declare -A flipCoinCombinations

#Flip a coin to display Head or Tail
function flipACoin() {
	isHead=1
	randomCheck=$((RANDOM%2))
	if [ $randomCheck -eq $isHead ]
	then
		coinSide+=H
	else
		coinSide+=T
	fi
}

#To get all the combinations of the coins
function coinCombinations() {
	numberOfCoins=$1
	for ((i=1; i<=$numberOfFlips; i++))
	do
		coinSide=""
		for ((j=1; j<=$numberOfCoins; j++))
		do
			flipACoin
		done
		storeInDictionary $coinSide $2
	done
	echo "Keys:       ${!flipCoinCombinations[@]}"
	echo "Count:      ${flipCoinCombinations[@]}"
	calculatePercentage
}

#To store the combinations in a Dictionary
function storeInDictionary() {
	flipCoinCombinations[$coinSide]=$((${flipCoinCombinations[$coinSide]} + 1))
}

#To calculate percentages of the combinations
function calculatePercentage() {
	for i in ${!flipCoinCombinations[@]}
	do
		flipCoinCombinations[$i]=$(($((${flipCoinCombinations[$i]}*100))/$numberOfFlips))
	done
	echo "Percentage: ${flipCoinCombinations[@]}"
}

#Main
read -p "Enter the number of times you want to flip a coin: " numberOfFlips
coinCombinations $SINGLET flipCoinCombinations
