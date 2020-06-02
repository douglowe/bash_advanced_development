

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
template_download='scenario_settings/download_template.txt'

scen_number=0
down_number=0

while [ "$day" != "$endday" ] || [ "$month" != "$endmonth" ] || [ "$year" != "$endyear" ] ; do


	web_dir='http://manunicast.seaes.manchester.ac.uk/charts/manunicast/'${year}${month}${day}'/d02/meteograms/'
	read getyear getmonth getday <<< $(determine_next_date - 1 $year $month $day)
	storage_dir='meteograms/'${year}${month}${day}


	for station in ${stations[@]}; do
		
		download_file=$(printf 'scenario_settings/download_number_%.4i.txt' $down_number)
		data_file='meteo_'${station}'_'${getyear}'-'${getmonth}'-'${getday}'_1800_data.txt'		
		
		sed -e "s|%%STDIR%%|$storage_dir|g" -e "s|%%WEBDIR%%|$web_dir|g" \
			-e "s/%%WEBFILE%%/$data_file/g" $template_download > $download_file
	
		for variable in ${variables[@]}; do
		
			# set the scenario file name
			scen_file=$(printf 'scenario_settings/scen_number_%.4i.txt' $scen_number)
			
			sed -e "s/%%YEAR%%/$year/g" -e "s/%%MONTH%%/$month/g" \
				-e "s/%%DAY%%/$day/g" -e "s/%%STATION%%/$station/g" \
				-e "s/%%VARIABLE%%/$variable/g" $template_file > $scen_file

			
			# increment the scenario number
			let scen_number+=1
			
			
		done
		
		let down_number+=1
		
	done


	# set next date
	read year month day <<< $(determine_next_date + 1 $year $month $day)


done

