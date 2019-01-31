#!/usr/local/bin/python3

from os import listdir
from os.path import isfile, join
from datetime import datetime
from dateutil.parser import parse
from inspect import currentframe, getframeinfo
from pathlib import Path


FILENAME = getframeinfo(currentframe()).filename
# Directory this script is in regardless of where it's being called from.
DIR = Path(FILENAME).resolve().parent
FILE_PREFIX = 'soa_'  # Whatever file is called before dt stamp
PREFIX_LENGTH = len(FILE_PREFIX)  # Just to make script more readable

# Get list of log files
files = [filename for filename in listdir(DIR) if isfile(
    join(DIR, filename)) and FILE_PREFIX in filename and filename[-4:] == '.log']


# Create list of dictionaries for sorting
logs = []
for file in files:
    if file[0:PREFIX_LENGTH] == FILE_PREFIX:
        dt_string = file[PREFIX_LENGTH:-4].replace('_', ' ')
        dt = parse(dt_string)
        log = {
            'file_name': file,
            'timestamp': dt
        }
        logs.append(log)

# Files are almost certainly already sorted, but just to be safe...
sorted_logs = sorted(logs, key=lambda k: k['timestamp'])

# If you want to count on the files being sorted, which you probably can,
# just delete from "# Create list..." to here, and...
last_log_filename = sorted_logs[-1]['file_name']
second_last_log_filename = sorted_logs[-2]['file_name']
# replace the last two lines with:
# last_log_filename = logs[-1]
# second_last_log_filename = logs[-2]


# Get last two log contents as arrays of strings

with open(DIR/second_last_log_filename, "r") as file:
    second_last_log = file.readlines()

with open(DIR/last_log_filename, "r") as file:
    last_log = file.readlines()

# TODO Now that we have the file names of the most recent 2 logs,
# we just have to figure out what exactly "different" means


with open(DIR / "test.txt", "a") as myfile:
    myfile.write(datetime.now() + "\n")
