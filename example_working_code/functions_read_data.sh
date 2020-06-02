#
#  bash functions for reading the ManUniCast meteograms
#

read_dataline () {

	if [[ $1 == '' ]] || [[ $2 == '' ]] ; then
		echo "This function reads data from a specified file, for a specified variable."
		echo "usage: read_dataline [filepath/filename] [variable]"
		return 1		
	fi

	# select line of text, pull out values, strip off the [ ] brackets, and replace ',' with ' '
	local text_line=$(grep -i $2 $1 | grep -Eo "\[.*\]" | sed -e 's/\[//g' -e 's/\]//g' -e 's/,/ /g' )  
	
	
	# split the line of text (assuming default delimiter of ' '), and save to an array
	read -r -a data_array <<< "$text_line"	

}
