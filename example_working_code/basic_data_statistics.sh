#
#  This script runs basic stats analysis on a scenario defined in the
#  scenario settings file that will be passed as an argument to this script.
#  It is designed to be run by step 3 script.
#  

. functions_date_math.sh
. functions_read_data.sh
. functions_random_delay.sh

# read in scenario configuration
. $1



#year=2020
#month=01
#day=08

#station='ABED'
#variable='td2m'

#storage_dir='meteograms/'${year}${month}${day}
storage_dir=${data_dir}${year}${month}${day}

# check that the stats directory exists, if not then create it
[ -e $stats_dir ] || mkdir -p $stats_dir

# set the get date, for the file names
read getyear getmonth getday <<< $(determine_next_date - 1 $year $month $day)

# setup the filepath/filename
data_file='meteo_'${station}'_'${getyear}'-'${getmonth}'-'${getday}'_1800_data.txt'
address=${storage_dir}/${data_file}

# read the variable from the data file - this creates the array "data_array"
read_dataline $address $variable

# introduce a random delay to this process
random_delay
#random_delay_break

# calculate the basic statistics for our data
read minimum <<< $(printf '%s\n' "${data_array[@]}" | awk -f minimum.awk)
read maximum <<< $(printf '%s\n' "${data_array[@]}" | awk -f maximum.awk)
read count average <<< $(printf '%s\n' "${data_array[@]}" | awk -f average.awk)
read total <<< $(printf '%s\n' "${data_array[@]}" | awk -f sum.awk)

# print the stats out
outfile="${stats_dir}stats_${station}_${variable}_${year}${month}${day}.txt"
printf 'Statistics for variable %s at station %s\n' "$variable" "$station" > $outfile
printf 'Minimum value = %s\n' "$minimum" >> $outfile
printf 'Maximum value = %s\n' "$maximum" >> $outfile
printf 'Data count = %s\n' "$count" >> $outfile
printf 'Average value = %s\n' "$average" >> $outfile
