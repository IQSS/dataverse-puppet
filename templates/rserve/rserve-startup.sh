#!/usr/bin/env sh

### BEGIN INIT INFO
# Provides:             rserve
# Required-Start:       $network $local_fs $remote_fs
# Required-Stop:
# Default-Start:        2 3 4 5
# Default-Stop:         0 1 6
# Short-Description:    R daemon server
### END INIT INFO


DAEMON="Rserve"
USER="<%= scope.lookupvar('dataverse::rserve::rserve_user') %>"
LOG="/var/log/rserve/Rserve.log"


restart() {
    echo -n "Stopping ${DAEMON} daemon: "
    killall -s 9 $DAEMON
    echo -n "Starting ${DAEMON} daemon: "
    echo "."
    su $USER -c "/usr/bin/R --vanilla --slave CMD ${DAEMON} >> ${LOG} 2>&1"
}

start() {
    echo -n "Starting ${DAEMON} daemon: "
    echo "."
    su $USER -c "/usr/bin/R --vanilla --slave CMD ${DAEMON} >> ${LOG} 2>&1"
}

status() {
    ps cax | grep $DAEMON
    if [ $? = 0 ] ; then
        echo -n "Status ${DAEMON} daemon: running"
        echo "."
        exit 0
    else
        echo -n "Status ${DAEMON} daemon: not running"
        echo "."
        exit 2
    fi
}

stop() {
    echo -n "Stopping ${DAEMON} daemon: "
    killall -s 9 $DAEMON
    echo "."
}

main() {

    case "$1" in
        start)
            start
            exit $?
        ;;
        stop)
            stop
            exit 0
        ;;
        status)
            status
        ;;
        restart)
            restart
            exit $?
        ;;
        *)
            echo "Usage: /etc/init.d/rserve {start|stop|status|restart}"
            exit 1
    esac
}

main $@