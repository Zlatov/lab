#!/bin/bash

# Переименовать MATH в сервис

### BEGIN INIT INFO
# Provides:                 MATH
# Required-Start:           $java
# Required-Stop:            $java
# Short-Description:        Start and stop MATH service.
# Description:              -
# Date-Creation:            -
# Date-Last-Modification:   -
# Author:                   -
### END INIT INFO

# Variables
PGREP=/usr/bin/pgrep
JAVA=/usr/bin/java
ZERO=0

# Start the MATH
start() {
    echo "Starting MATH..."
    #Verify if the service is running
    $PGREP -f MATH > /dev/null
    VERIFIER=$?
    if [ $ZERO = $VERIFIER ]
    then
        echo "The service is already running"
    else
        #Run the jar file MATH service
        $JAVA -jar /opt/MATH/MATH.jar > /dev/null 2>&1 &
        #sleep time before the service verification
        sleep 10
        #Verify if the service is running
        $PGREP -f MATH  > /dev/null
        VERIFIER=$?
        if [ $ZERO = $VERIFIER ]
        then
            echo "Service was successfully started"
        else
            echo "Failed to start service"
        fi
    fi
    echo
}

# Stop the MATH
stop() {
    echo "Stopping MATH..."
    #Verify if the service is running
    $PGREP -f MATH > /dev/null
    VERIFIER=$?
    if [ $ZERO = $VERIFIER ]
    then
        #Kill the pid of java with the service name
        kill -9 $($PGREP -f MATH)
        #Sleep time before the service verification
        sleep 10
        #Verify if the service is running
        $PGREP -f MATH  > /dev/null
        VERIFIER=$?
        if [ $ZERO = $VERIFIER ]
        then
            echo "Failed to stop service"
        else
            echo "Service was successfully stopped"
        fi
    else
        echo "The service is already stopped"
    fi
    echo
}

# Verify the status of MATH
status() {
    echo "Checking status of MATH..."
    #Verify if the service is running
    $PGREP -f MATH > /dev/null
    VERIFIER=$?
    if [ $ZERO = $VERIFIER ]
    then
        echo "Service is running"
    else
        echo "Service is stopped"
    fi
    echo
}

# Main logic
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    status)
        status
        ;;
    restart|reload)
        stop
        start
        ;;
  *)
    echo $"Usage: $0 {start|stop|status|restart|reload}"
    exit 1
esac
exit 0