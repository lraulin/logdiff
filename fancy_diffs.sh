#!/bin/sh

cd logs
for f in *; do
    DIFF=$(diff $f ../logs.prev/$f)
    if [ -n "$DIFF" ]; then
        #echo "********************\nDiffs for $f\n********************" >> ../diffs.log
        diff-so-fancy $f ../logs.prev/$f 
    fi                                  
done                                            

echo 'Done.'
