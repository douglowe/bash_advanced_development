#
# Final (local) report writing script (2)
#
#   This script should:
#      1) (robustly) find a given date/time in all files for a list of given station locations
#      2) pull all data out for that date/time
#      3) write out reports of the changes / range of these for each station
#

. functions_date_math.sh
. functions_download.sh



startyear=2020
startmonth=01
startday=05

endyear=2020
endmonth=01
endday=10

stations=( ABED HOLM INV VALL YORK MILL )

#getyear=2020
#getmonth=01
#getday=04



year=${startyear}
month=${startmonth}
day=${startday}

echo $day $endday

echo "outside loop"
while [ "$day" != "$endday" ] || [ "$month" != "$endmonth" ] || [ "$year" != "$endyear" ] ; do

	echo "inside while loop"

	web_dir='http://manunicast.seaes.manchester.ac.uk/charts/manunicast/'${year}${month}${day}'/d02/meteograms/'

	if check_data_exists $web_dir ; then
		echo "working on date ${year}${month}${day}"

		# set the get date, for the file names
		read getyear getmonth getday <<< $(determine_next_date - 1 $year $month $day)

		for station in ${stations[@]}; do

			data_file='meteo_'${station}'_'${getyear}'-'${getmonth}'-'${getday}'_1800_data.txt'
			address=${web_dir}${data_file}

			storage_dir='meteograms/'${year}${month}${day}


			if check_data_exists $address ; then
				echo "downloading data for station ${station}"
				download_save_data $address $storage_dir
			else
				echo "data doesn't exist for station ${station}"
			fi

		done


	else
		echo "data doesn't exist for date ${year}${month}${day}"	
	fi

	# set next date
	read year month day <<< $(determine_next_date + 1 $year $month $day)


done
