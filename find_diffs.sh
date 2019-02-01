#!/bin/sh

# Set bash to "expand" pattern to null string instead of pattern if there are 
# no matches so we can check if directory is empty
shopt -s nullglob

# Move logs
cd logs
echo 'Moving old logs...'
if [ $(ls -l | wc -l) -ne 0 ]; then   # if the number of files/directories is not 0
    for f in *; do
        mv -- "$f" "../logs.prev/"    # move all the files to the logs.prev directory
    done
else
    echo 'No files to move'
#     echo "The log file directory is empty. Quitting..."
#     exit 126                          # exit with status "The command can't execute"
fi

cd ../
echo 'Fetching new logs...'
sh get_logs.sh                        # get new logs

cd logs
echo 'Comparing logs...'

echo "" > ../diffs.log

if [ $(ls -l ../logs.prev | wc -l) -ne 0 ]; then  
    for f in *; do
        DIFF=$(diff $f ../logs.prev/$f)
        if [ -n "$DIFF" ]; then
            echo "********************\nDiffs for $f\n********************" >> ../diffs.log
            diff $f ../logs.prev/$f >> ../diffs.log # compare each log in new folder to log in old folder
        fi                                          # and save differences in file
    done                                            
else
    echo 'No old logs to compare.'
fi

echo 'Done.'