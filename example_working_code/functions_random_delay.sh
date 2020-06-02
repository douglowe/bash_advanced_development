#
#  bash functions for slowing down eager students!
#



random_delay () {
	period=$((5 + RANDOM % 10))
	echo "waiting for period $period"
	sleep $period
}

random_delay_break () {
	period=$((5 + RANDOM % 10))
	echo "waiting for period $period"
	sleep $period
	
	chance=$((RANDOM % 100))
	if [[ $chance -gt 90 ]];then
		echo "run failed"
		exit 1
	fi
}


