#!/usr/bin/python

# fetch-sequency.py

# This function fetches the human genome sequence from the Genome Browser using
# the UCSC DAS server given a chromosome name, start and stop coordinate, and
# hg build. On retrieval, the function prints the DNA sequence directly to the
# terminal.

# Usage:
#  > python fetch-sequence.py [chr#] [start coordinate] [stop coordinate] [hg build]

# Example input and output: 
#  > python fetch-sequence.py 12 100000 100020 38 
#  > TGTCTCCATTCTGCACGTTTCTCTTTTCTTGACTTGTTCTTTACTCCACTT

# Citations
# https://stackoverflow.com/questions/22328319/python-fetch-sequence-from-das-by-coordinates

import sys
from lxml import etree

def main():

    # Chromosome name
    chromosome = sys.argv[1]

    # Start coordinate
    start = sys.argv[2]

    # Stop coordinate
    stop = sys.argv[3]

    # hg build
    hg = sys.argv[4]

    # Download sequence
    base = 'http://genome.ucsc.edu/cgi-bin/das/hg' + hg + '/dna?segment='
    url = base + chromosome + ':' + start + ',' + stop
    doc = etree.parse(url,parser=etree.XMLParser())
    if doc != '':
        sequence = doc.xpath('SEQUENCE/DNA/text()')[0].replace('\n','')
    else:
        sequence = 'sequence not found. check coordinates.'

    # Print sequence to terminal
    print ((sequence).upper())

# Standard call as main() function
if __name__ == '__main__':
  main()
