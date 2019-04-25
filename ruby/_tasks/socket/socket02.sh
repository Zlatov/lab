#!/bin/bash

# Скопировать в /etc/init.d или /etc/rc/init.d
# sudo cp -T socket02.sh /etc/init.d/socket02
# sudo chmod 755 /etc/init.d/socket02
# sudo service socket02 start

### BEGIN INIT INFO
# Provides:                 socket02
# Short-Description:        Start and stop socket02 service.
# Description:              -
# Date-Creation:            -
# Date-Last-Modification:   -
# Author:                   -
### END INIT INFO

# Variables
PGREP=/usr/bin/pgrep
DIR_PATH=/usr/local/bin
ZERO=0

# Start the socket02
start() {
    echo "Starting socket02..."
    #Verify if the service is running
    $PGREP -f socket02 > /dev/null
    VERIFIER=$?
    if [ $ZERO = $VERIFIER ]
    then
        echo "The service is already running"
    else
        #Run socket02 service
        "${DIR_PATH}/socket02" > /dev/null 2>&1 &
        #sleep time before the service verification
        sleep 10
        #Verify if the service is running
        $PGREP -f socket02  > /dev/null
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

# Stop the socket02
stop() {
    echo "Stopping socket02..."
    #Verify if the service is running
    $PGREP -f socket02 > /dev/null
    VERIFIER=$?
    if [ $ZERO = $VERIFIER ]
    then
        #Kill the pid of java with the service name
        kill -9 $($PGREP -f socket02)
        #Sleep time before the service verification
        sleep 10
        #Verify if the service is running
        $PGREP -f socket02  > /dev/null
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

# Verify the status of socket02
status() {
    echo "Checking status of socket02..."
    #Verify if the service is running
    $PGREP -f socket02 > /dev/null
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