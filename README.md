# Example Scripts for the BASH Programming Course (Workflow Management)

These scripts are intended as an example of how to use some of the bash 
features that you were taught about on the course. The scripts will
download meteogram data from the ManUniCast archives (these are created 
from the daily forecast simulations that are run for that site), create
a set of scenario configuration files for your analysis, and then run a 
simple statistical analysis of the data for you.

The scripts are kept in the `example_working_code` directory. They are
over-engineered, because they are intended to show (almost) all the different
functions that you were shown in the lessons. For your own work start off
with simpler scripts than this - but make sure to prioritise readability
(and try not to have one single, long, script which does everything, but then is
difficult to maintain).

## Running the Workflow

Running order:
- `step01_download_data.sh`
- `step02_create_scenario_configuration_files.sh`
- `step03_data_statistics.sh`

Step 1 will download meteogram data for the stations listed, between the start
and end dates that have been defined (all definitions should be set in the 
`step01_download_data.sh` file itself).

Step 2 will create the scenario configuration files, based on the template file
`example_working_code/scenario_settings/config_template.txt`, and using the settings
given in the `step02_create_scenario_configurations_files.sh` script (same as above).
Scenario configuration files will be stored in the `example_working_code/scenario_settings`
directory.

Step 3 will run the stats analysis, for a given range of scenarios (this step
is agnostic about what the scenario configurations are - you need to make sure you
define these in step 2). Stats data will be stored as text files in the directory
`example_working_code/stats_analysis` (which will be created if it doesn't already exist).

## Examining the working code

The organisational scripts described above source functions from the bash scripts
`functions_date_math.sh`, `functions_download.sh`, `functions_read_data.sh`. There's also 
a script `functions_random_delay.sh`, designed to add the experience of waiting for
more complex workflows to finish.

The step 3 script calls the `basic_data_statistics.sh` script for each scenario you wish
to process - when it does this it passes the scenario configuration file as an argument, and
this script then sources that file, to read in the scenario settings.
