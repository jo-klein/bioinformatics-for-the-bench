#!/bin/bash

# fetch-fastq.sh

# Joshua Klein 10-22-2021

# This script takes the first and last NCBI SRA run accession
# values for a project and downloads the files in that range
# in fastq format.

# Usage
#   Type the following at the terminal prompt and press enter:
#     > fetch-fastq.sh <start> <end> -s -o /path/to/directory/
#
# Example
#     > fetch-fastq.sh SRR13479833 SRR13479835 -s -o ./SRA/
#
# This will create the directory SRA in the current working
# directory if not already present and then download SRR13479833
# SRR13479834, and SRR13479835 to ./SRA/ while splitting the
# fastq files into read 1 and read 2.
 
# Flags
#   -s Optional flag for splitting paired end runs into separate
#      fastq files.
#   -d Optional flag to specify a save-to directory. Will create
#      the directory if not present. Default path is the current
#      working directory.

# Dependencies
#   sra-tools (tested with 2.10.1; fails with current release of 2.11.0)

# References
#   https://stackoverflow.com/questions/47058318/bash-script-to-test-for-only-presence-of-flag

START=$1
STOP=$2
shift 2

# Process optional flags
while getopts 'so:' flag; do
  case "${flag}" in
    s) s="--split-files" ;;
    o) o="${OPTARG}"     ;;
  esac
done

# Make directory if not found
if [ ! -d $o ]; then
  mkdir $o
fi

# Loop through and download SRA runs
echo
for (( c=${START#???}; c<=${STOP#???}; c++ )); do
  FILE="${START:0:3}${c}"
  echo $FILE.fastq
  fasterq-dump $s $FILE -O ${o:-./} &> /dev/null
done

echo
echo "Process complete"
echo
