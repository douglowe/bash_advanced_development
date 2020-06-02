#
#
#  bash functions for downloading data from manunicast website
#
#    Step 1: check to make sure data exists for the chosen date & location
#    Step 2: download data, and archive in a sensible place
#
# set -e ### don't use! 



check_data_exists () {

	#remote_ok=`wget --no-cache -N --spider -v $address 2>&1 | grep -c 'Remote file exists' || true`  ### designed to cope with 'set -e'
	remote_ok=`wget --no-cache -N --spider -v $1 2>&1 | grep -c 'Remote file exists'`

	if [ ${remote_ok} == 1 ]; then
		#echo "true"
		return 0
	else
		#echo "false"
		return 1
	fi
}


download_save_data () {
	[ -e $storage_dir ] || mkdir -p $storage_dir || { echo "exiting download_save_data, see error" ; exit 1; }
	wget --no-cache -nd -nv -N $address -P $storage_dir 
	return 0
}
