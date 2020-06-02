#!/bin/bash --login
#$ -cwd
#$ -t 1-15
#
#
#  Script for organising running the analysis scripts for ManUniCast stats extraction.
#

# count number of scenarios:
end_index=$(ls -1 scenario_settings/scen_number_* | wc -l)

index=$((SGE_TASK_ID-1))

step=${SGE_TASK_LAST} 


while [[ $index -lt $end_index ]] ; do

	success=0
	
	while [[ $success -lt 1 ]] ; do
		echo "calculate stats for scenario $index"
		scenario_file=$(printf 'scenario_settings/scen_number_%.4i.txt' $index)
		bash basic_data_statistics.sh $scenario_file && ((success+=1)) || echo "  failed..."
	done
	

	((index+=$step))
done

