#
#  Script for organising running the analysis scripts for ManUniCast stats extraction.
#
#  Here we set the start and end scenario numbers explicitly. You will want to check 
#  what scenarios are available in the scenario_settings directory when you set these.
#

start_scenario=0
end_scenario=100


scen_number=$start_scenario

success=0
required=$(($end_scenario-$start_scenario))

rm log_*.txt


while [[ scen_number -le end_scenario ]]; do

	scenario_file=$(printf 'scenario_settings/scen_number_%.4i.txt' $scen_number)
	log_file=$(printf 'log_%.4i.txt' $scen_number)

	bash basic_data_statistics.sh $scenario_file && echo "done" > $log_file || echo "failed" > $log_file &

	let scen_number+=1

done


while [[ $success -lt $required ]]; do

	sleep 2
	
	success=0
	scen_number=$start_scenario
	
	while [[ scen_number -le end_scenario ]]; do
		log_file=$(printf 'log_%.4i.txt' $scen_number)
		
		if [ -e $log_file ]; then
			if [ $(grep 'done' $log_file) ]; then
				let success+=1
			else
				rm $log_file
				bash basic_data_statistics.sh $scenario_file && echo "done" > $log_file || echo "failed" > $log_file &
			fi
		fi
		
		let scen_number+=1
	done
	
	echo "finished scenarios = $success"

done

echo "finished"
