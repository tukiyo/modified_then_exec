#!/bin/sh

SLEEP=1

execute() {
    echo "[$(date +"%Y/%m/%d %H:%M:%S")] $COMMAND ________________________________"
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
TIME_MODIFY=$(du -b $FILENAME)

while true;do
    CHECK_TIME=$(du -b $FILENAME)
    if [ "$TIME_MODIFY" != "$CHECK_TIME" ]; then
        execute
    fi
    sleep $SLEEP
done
