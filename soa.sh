#!/bin/bash

# Directory of script regardless of where it is called from
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
STAMP=`date '+%Y-%m-%d_%H:%M:%S_%Z'` # Ex: 2019-01-25_14:53:33_EST
DOMAIN_LIST="google.com yahoo.com msn.com"

dig $DOMAIN_LIST ANY > "$DIR/soa_${STAMP}.log"

# Get whatever to send

# Send with mail
#mail -s "Header" <email@address.com>