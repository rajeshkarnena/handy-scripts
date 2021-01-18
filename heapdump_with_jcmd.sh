#!/bin/sh
# Takes the JavaApp PID as an argument.
# Captures heap dump of the given Java process.
# Heap dumps will be collected in the file "debug/jcmd_heapdump_y-m-d_h-m-s.hprof".
#   Usage:
#          ./heapdump_with_jcmd.sh <JAVA_APP_PID>
################################################################################################

# Where to generate the heap dumps & top output files.
WHERE_TO_GENERATE_OUTPUT_FILES="debug"

# Setting the Java Home, by giving the path where your JDK is kept
JAVA_HOME=/usr/java/default

_timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

mkdir -p $WHERE_TO_GENERATE_OUTPUT_FILES
sudo chown -R app:app /app/$WHERE_TO_GENERATE_OUTPUT_FILES/
echo "Writing heap dumps to Directory:  $WHERE_TO_GENERATE_OUTPUT_FILES"
cd $JAVA_HOME/bin
nohup sudo -u app jcmd $1 GC.heap_dump /app/$WHERE_TO_GENERATE_OUTPUT_FILES/jcmd_heapdump_${_timestamp}.hprof &
