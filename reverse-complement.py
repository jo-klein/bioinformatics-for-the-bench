#!/usr/bin/python

# reverse-complement.py

# Joshua Klein 10-16-2021

# This function converts a given nucleic acid sequence into its
# reverse complement and prints the result directly to the
# terminal. Non-ATCG characters are returned as uppercase.

# Usage:
#  > python reverse-complement.py [nucleic acid sequence]

# Example input and output: 
#  > python reverse-complement.py TGTCTCCATTCTGCACGTTTCTCT.ttcttg
#  > CAAGAA.AGAGAAACGTGCAGAATGGAGACA

import sys

def main():

    # User given sequence
    sequence = sys.argv[1].upper()

    # Start with empty string variable
    reverseComplement = ''
    
    # Create dictionary of base pairs
    d = {'A':'T', 'T':'A', 'C':'G', 'G':'C'}

    # Build the complementary sequence one base at a time
    for base in range(0, len(sequence)):
      try:
	      # Add the complementary base
        reverseComplement = reverseComplement + d[sequence[base]]
      except:
	      # Return non-ATCG characters in uppercase
        reverseComplement = reverseComplement + sequence[base]

    # Print sequence in reverse to terminal
    print (reverseComplement[::-1])

# Standard call as main() function
if __name__ == '__main__':
  main()
