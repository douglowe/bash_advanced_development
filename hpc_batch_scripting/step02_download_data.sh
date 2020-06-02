#!/bin/bash --login
#$ -cwd
#$ -t 1-10
#
# Script for downloading the ManUniCast meteogram data using a job array.
#

. functions_date_math.sh
. functions_download.sh

module unload tools/env/proxy2


# count number of scenarios:
end_index=$(ls -1 scenario_settings/download_number_* | wc -l)

index=$((SGE_TASK_ID-1))

step=${SGE_TASK_LAST} 


while [[ $index -lt $end_index ]] ; do

	down_settings=$(printf 'scenario_settings/download_number_%.4i.txt' $index)

	. $down_settings
	
	if check_data_exists $webdir ; then
		echo "directory $webdir exists"

		address=${webdir}${webfile}
		
		if check_data_exists $address ; then
			echo "downloading file $webfile"
			download_save_data $address $storagedir
		else
			echo "file $webfile doesn't exist"
		fi

	else
		echo "directory $webdir doesn't exist"
	fi


	((index+=$step))

done

