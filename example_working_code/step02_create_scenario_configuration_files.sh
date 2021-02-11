#
#  This script will create the configuration files needed for step 3 from a
#  template file in the 'scenario_settings' folder.
#
#  Each of these scenarios will be for a single day, station, and meteorological variable.
#


. functions_date_math.sh


startyear=2020
startmonth=01
startday=05

endyear=2020
endmonth=01
endday=10

stations=( ABED HOLM INV VALL YORK )

variables=( slp temp2m td2m rh2m wspd wdir precip )


year=${startyear}
month=${startmonth}
day=${startday}


template_file='scenario_settings/config_template.txt'


scen_number=0

while [ "$day" != "$endday" ] || [ "$month" != "$endmonth" ] || [ "$year" != "$endyear" ] ; do


	for station in ${stations[@]}; do
		for variable in ${variables[@]}; do
		
			# set the scenario file name
			scen_file=$(printf 'scenario_settings/scen_number_%.4i.txt' $scen_number)
			
			sed -e "s/%%YEAR%%/$year/g" -e "s/%%MONTH%%/$month/g" \
				-e "s/%%DAY%%/$day/g" -e "s/%%STATION%%/$station/g" \
				-e "s/%%VARIABLE%%/$variable/g" $template_file > $scen_file

			
			# increment the scenario number
			let scen_number+=1
		done
	done


	# set next date
	read year month day <<< $(determine_next_date + 1 $year $month $day)


done
