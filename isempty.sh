#!/bin/sh


if [ $(ls -l $1 | wc -l) -eq 0 ]; then   # if the number of files/directories is 0
    echo 'The log file directory is empty. Quitting...'
    exit 126                          # exit with status "The command can't execute"
else
    echo 'There are files and/or directories here!'
fi