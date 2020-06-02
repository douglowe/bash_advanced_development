#!/bin/bash --login
#$ -cwd
#$ -t 1-10
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


# count number of scenarios:
end_index=$(ls -1 scenario_settings/download_number_* | wc -l)

index=$((SGE_TASK_ID-1))



while [[ $index -le $end_index ]] ; do

	down_settings=$(printf 'scenario_settings/download_number_%.4i.txt' $index)

	. $down_settings
	
	if check_data_exists $web_dir ; then
		echo "directory $web_dir exists"

		address=${web_dir}${webfile}
		
		if check_data_exists $address ; then
			echo "downloading file $webfile"
			download_save_data $address $storagedir
		else
			echo "file $webfile doesn't exist"
		fi

	else
		echo "directory $webdir doesn't exist"
	fi


	((index+=10))

done

