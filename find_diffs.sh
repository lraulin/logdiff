#!/bin/sh

DIR='/tmp/soalogs'
mkdir -p $DIR/logs $DIR/logs.prev

# Set bash to "expand" pattern to null string instead of pattern if there are 
# no matches so we can check if directory is empty
shopt -s nullglob

# Move logs
echo 'Moving old logs...'
if [ $(ls -l $DIR/logs | wc -l) -ne 0 ]; then   # if the number of files/directories is not 0
    for f in $DIR/logs/*; do
        mv -- "$f" "$DIR/logs.prev/"    # move all the files to the logs.prev directory
    done
else
    echo 'No files to move'
#     echo "The log file directory is empty. Quitting..."
#     exit 126                          # exit with status "The command can't execute"
fi

echo 'Fetching new logs...'
cat $1 | while read in; do dig "$in" -t ANY | sed '/^;;/d; /^; EDNS/d; /^; <<>>/d'  > $DIR/logs/"$in"; done


echo 'Comparing logs...'

echo "" > $DIR/diffs.log

cd $DIR/logs
if [ $(ls -l ../logs.prev | wc -l) -ne 0 ]; then  
    for f in *; do
        DIFF=$(diff $f ../logs.prev/$f)
        if [ -n "$DIFF" ]; then
            echo "********************\nDiffs for $f\n********************" >> $DIR/diffs.log
            diff $f ../logs.prev/$f >> $DIR/diffs.log # compare each log in new folder to log in old folder
        fi                                          # and save differences in file
    done                                            
else
    echo 'No old logs to compare.'
fi

cat $DIR/diffs.log

echo 'Done.'