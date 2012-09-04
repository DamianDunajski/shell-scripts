#!/bin/bash

if [ $# != 1 ]
then
    echo "Usage: $0 destination";
    echo "       - destination: a location where files should be copied"
    exit;
fi

rsync_command="rsync -rlpt --delete --exclude=/META-INF --exclude=/WEB-INF/lib --exclude=/WEB-INF/classes --exclude=*.xml"
rsync_src="src/main/webapp/"
rsync_dst=${1}

if [ ! -e $rsync_src ]
then
    echo "Source directory [$rsync_src] doesn't exist";
    exit;
fi

inotifywait -m -r -e create,move,delete,modify ${rsync_src} | while read; do eval $rsync_command $rsync_src $rsync_dst; done
