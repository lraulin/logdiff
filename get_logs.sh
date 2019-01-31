cat domains.lst | while read in; do dig "$in" -t ANY | sed '/^;;/d; /^; EDNS/d; /^; <<>>/d'  >> /Users/leeraulin/Projects/logdiff/logs/"$in"; done
