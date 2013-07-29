#!/bin/sh

SLEEP=1

execute() {
    echo "[$CHECK_TIME] $COMMAND ________________________________"
    $COMMAND
    TIME_MODIFY=$CHECK_TIME
}

validate() {
    if [ "$COMMAND" = "" ]; then
        echo "[usage] $0 filename 'command' need."
        exit 0
    elif [ ! -e "$FILENAME" ]; then
        echo "[quit] $FILENAME no such file or directory."
        exit 0
    fi
}

FILENAME=$1
COMMAND=$2
validate
TIME_MODIFY=$(date -r $FILENAME)

while true;do
    CHECK_TIME=$(date -r $FILENAME)
    if [ "$TIME_MODIFY" != "$CHECK_TIME" ]; then
        execute
    fi
    sleep $SLEEP
done
