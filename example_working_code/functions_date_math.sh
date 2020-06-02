#
#  bash functions for controlling date math
#
#  To do: add check for system (so that we can use these on linux or OSX)
#


determine_next_date () {

	if [[ ! $1 =~ [+-]{1} ]] \
			|| [[ ! $2 =~ ^[0-9]{1,9}$ ]] \
			|| [[ ! $3 =~ ^[0-9]{4}$ ]] \
			|| [[ ! $4 =~ ^[0-9]{1,2}$ || $4 -lt 1 || $4 > 12 ]] \
			|| [[ ! $5 =~ ^[0-9]{1,2}$ || $5 > 31 ]] ; then           
			## need -lt for comparison with 1, but use > for comparison with 12
			## don't use -gt, as bash will assume 04, etc, are octal
		echo "This function determines the next date, using a specified offset."
		echo "usage: determine_next_date [+/-] [#days] [current year] [current month] [current day]"
		exit 1
	fi

	if [[ "$OSTYPE" =~ "linux" ]]; then
		local next_year=$( date -d "$3$4$5 $1 $2 day" +%Y )
		local next_month=$( date -d "$3$4$5 $1 $2 day" +%m )
		local next_day=$( date -d "$3$4$5 $1 $2 day" +%d )
	elif [[ "$OSTYPE" =~ "darwin" ]]; then
		local next_year=$(date -v ${1}${2}d -j -f "%Y %m %d" "$3 $4 $5" +%Y)
		local next_month=$(date -v ${1}${2}d -j -f "%Y %m %d" "$3 $4 $5" +%m)
		local next_day=$(date -v ${1}${2}d -j -f "%Y %m %d" "$3 $4 $5" +%d)
	else
		echo "OS type unrecognised: $OSTYPE"
		exit 1
	fi

	echo $next_year $next_month $next_day

}

increment_dates () {

	if [[ ! $1 =~ [+-]{1} ]] || [[ ! $2 =~ [0-9]{1,9} ]] || [[ ! $3 =~ [0-9]{4} ]] || [[ ! $4 =~ [0-9]{1,2} ]] || [[ ! $5 =~ [0-9]{1,2} ]] ; then
		echo "This function determines the next date, using a specified offset."
		echo "usage: determine_next_date [+/-] [#days] [current year] [current month] [current day]"
		return 1
	fi

	if [ -z $next_year ]; then 
		read next_year next_month next_day <<< $(determine_next_date $1 $2 $3 $4 $5)
	fi
	curr_year=$next_year
	curr_month=$next_month
	curr_day=$next_day
	read next_year next_month next_day <<< $(determine_next_date $1 $2 $curr_year $curr_month $curr_day)
	
}
