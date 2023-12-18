#!/bin/bash

# default values
minsize=1
n=-1
see=0
dir=.

# help
if [ "$1" == "--help" ]
then
    echo "help: $0 [command]
USAGE: topsize [--help] [-h] [-N] [-s minsize] [--] [dir...]
--help - output format help and exit
-N - the number of files, if not specified, then all files
minsize - the minimum size, if not specified, is 1 byte
-h - the output in a \"human-readable format\"
dir - search directory(-ies), if not specified, then the current directory
-- - separation of options and catalog"

    exit 0
fi

#options
while getopts 'N:h-s:' opt; do
    if [ $opt != "--" ]
    then
        case $opt in
	    N)n=$OPTARG
	      ;;
       	    h)see=1
	      ;;
	    s)minsize=$OPTARG
	      ;;
	    \?)echo "wrong option:$OPTARG">&2
	      exit 1
	      ;;
        esac
    fi
done

shift $((OPTIND-1))


if [ $n -gt -1 ]
then
    
    top=$(find "$dir" -type f -exec ls -lh {} \; | head -n | sort -nr |
                             \ awk '{print $9, ":", $5}'
else
    top=$(find "$@" -type f -exec du -ah {} + | sort -nr |
                             \awk '{print $1 "\t" $2}')
fi
#if [ -d "$dir" ]; then
#    find "$dir" -type f -exec ls -lh {} \; | awk '{print $9, ":", $5}'
exit 0
