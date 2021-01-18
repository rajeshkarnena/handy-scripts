#!/bin/sh
# Takes the JavaApp PID as an argument.
# Create thread dumps a specified number of times (i.e. LOOP) and INTERVAL.
# Thread dumps will be collected in the file "debug/jcmd_threaddump_y-m-d_h-m-s.out".
# CPU Usage will be collected in the file "debug/top_highcpu_y-m-d_h-m-s.out"
# Netstat details will be collected in the file "debug/netstat_details_y-m-d_h-m-s.out"
# Socket details will be collected in the file "debug/socket_details_y-m-d_h-m-s.out"
#   Usage:
#          ./threaddump_cpu_network_with_cmd.sh <JAVA_APP_PID>
################################################################################################

# Number of times to collect data. Means total number of thread dumps.
LOOP=10

# Interval in seconds between data points.
INTERVAL=10

# Where to generate the threddump & top output files.
WHERE_TO_GENERATE_OUTPUT_FILES="debug"

# Setting the Java Home, by giving the path where your JDK is kept
JAVA_HOME=/usr/java/default

_timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

mkdir -p $WHERE_TO_GENERATE_OUTPUT_FILES
echo "Writing data log files to Directory:  $WHERE_TO_GENERATE_OUTPUT_FILES"

for ((i=1; i <= $LOOP; i++))
  do
    $JAVA_HOME/bin/jcmd  $1  Thread.print >> $WHERE_TO_GENERATE_OUTPUT_FILES/jcmd_threaddump_${_timestamp}.out
    _now=$(date)
    echo "${_now}" >> $WHERE_TO_GENERATE_OUTPUT_FILES/top_highcpu_${_timestamp}.out
    top -b -n 1 -H -p $1 >> $WHERE_TO_GENERATE_OUTPUT_FILES/top_highcpu_${_timestamp}.out
    echo "Collected 'top' output and Thread Dump #" $i
    if [ $i -lt $LOOP ]; then
        echo "Sleeping for $INTERVAL seconds."
        sleep $INTERVAL
    fi
done

# Getting netstat details
netstat --tcp -p | grep $1 >> $WHERE_TO_GENERATE_OUTPUT_FILES/netstat_details_${_timestamp}.out
echo "Collected 'netstat' output"

# Getting socket details
lsof -i -a -p $1 >> $WHERE_TO_GENERATE_OUTPUT_FILES/socket_details_${_timestamp}.out
echo "Collected 'lsof' output"
