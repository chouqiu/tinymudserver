#!/bin/bash

SVR="tinymudserver";
pid=()

checkproc() {
    pid=(`ps aux | grep "$SVR" | grep -v grep | awk '{print $2}'`);
    echo "there're ${#pid[@]} processes running.";
}

stop() {
    checkproc;
    for p in ${pid[@]}
    do
        echo "killing $p ... ";
        kill $p;
    done
    pid=()
}

start() {
    ./$SVR > s.log 2>&1 &
    err=$?
    if (( $err == 0 ))
    then
        checkproc;
    else
        echo "run $SVR fail: $err";
        stop;
    fi;
}

case "$1" in
	"start" )
	start;
        ;;
        "stop" )
        stop;
        ;;
        * )
        checkproc;
        ;;
esac;   

