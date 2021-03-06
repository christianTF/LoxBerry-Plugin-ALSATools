#!/bin/sh

# Bashscript which is executed by bash *AFTER* complete installation is done
# (but *BEFORE* postupdate). Use with caution and remember, that all systems
# may be different! Better to do this in your own Pluginscript if possible.
#
# Exit code must be 0 if executed successfull.
#
# Will be executed as user "loxberry".
#
# We add 5 arguments when executing the script:
# command <TEMPFOLDER> <NAME> <FOLDER> <VERSION> <BASEFOLDER>
#
# For logging, print to STDOUT. You can use the following tags for showing
# different colorized information during plugin installation:
#
# <OK> This was ok!"
# <INFO> This is just for your information."
# <WARNING> This is a warning!"
# <ERROR> This is an error!"
# <FAIL> This is a fail!"

# To use important variables from command line use the following code:
ARGV0=$0 # Zero argument is shell command
# echo "<INFO> Command is: $ARGV0"

ARGV1=$1 # First argument is temp folder during install
# echo "<INFO> Temporary folder is: $ARGV1"

ARGV2=$2 # Second argument is Plugin-Name for scipts etc.
# echo "<INFO> (Short) Name is: $ARGV2"

ARGV3=$3 # Third argument is Plugin installation folder
# echo "<INFO> Installation folder is: $ARGV3"

ARGV4=$4 # Forth argument is Plugin version
# echo "<INFO> Installation folder is: $ARGV4"

ARGV5=$5 # Fifth argument is Base folder of LoxBerry
# echo "<INFO> Base folder is: $ARGV5"

echo "<INFO> Determining if we are running on Raspberry"
cat /etc/os-release | grep "ID=raspbian" > /dev/null
if [ $? -eq 0 ] ; then
	echo "Raspbian" > $ARGV5/config/plugins/$ARGV2/is_raspbian.info
	echo "<OK> Running on a Raspberry Pi"
else
	echo "<OK> This is not Raspberry hardware"
fi

echo "<INFO> Determining if we are running on a LoxBerry image"
uname -a | grep "loxberry" > /dev/null
if [ $? -eq 0 ] ; then
	echo "LoxBerry" > $ARGV5/config/plugins/$ARGV2/is_loxberry.info
	echo "<OK> Running in a LoxBerry image"
else
	echo "<OK> This is not a LoxBerry image"
fi

echo "<INFO> Starting service"
sudo $LBHOMEDIR/bin/plugins/$ARGV3/startstop-daemon.sh

# Exit with Status 0
exit 0
