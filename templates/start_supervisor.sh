#! /bin/bash -x

# HACER EL CHMOD DE LOS .py
NAME=supervisord
SUPERVISORD=`python -c "import supervisor;print supervisor.__path__[0]"`/supervisord.py
SUPERVISORCTL=`python -c "import supervisor;print supervisor.__path__[0]"`/supervisorctl.py
PIDFILE=/home/%(user)s/.supervisord.pid
OPTS="-c /home/%(user)s/webapps/supervisor/supervisord.conf"
PS=$NAME
TRUE=1
FALSE=0

test -x $SUPERVISORD || exit 0

export PATH="${PATH:+$PATH:}/usr/local/bin:/usr/sbin:/sbin:/home/%(user)s/bin:%(virtualenv)s/bin:"

isRunning(){
    pidof_daemon
    PID=$?

    if [ $PID -gt 0 ]; then
	return 1
    else
        return 0
    fi
}

pidof_daemon() {
    PIDS=`pidof -x $PS` || true

    [ -e $PIDFILE ] && PIDS2=`cat $PIDFILE`

    for i in $PIDS; do
        if [ "$i" = "$PIDS2" ]; then
            return 1
        fi
    done
    return 0
}

start () {
    echo "Starting Supervisor daemon manager..."
    isRunning
    isAlive=$?

    if [ "${isAlive}" -eq $TRUE ]; then
        echo "Supervisor is already running."
    else
        python $SUPERVISORD $OPTS || echo "Failed...!"
        echo "OK"
    fi
}

stop () {
    echo "Stopping Supervisor daemon manager..."
    python $SUPERVISORCTL $OPTS shutdown ||  echo "Failed...!"
    echo "OK"
}

case "$1" in
  start)
    start
	;;

  stop)
    stop
	;;

  restart|reload|force-reload)
    stop
    start
    ;;

esac

exit 0
