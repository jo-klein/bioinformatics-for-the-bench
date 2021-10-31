# compbio-tools-for-the-bench
Computational biology tools for bench scientists who are new to Python and bash scripting

This repo contains computational biology tools for common tasks in biology research. They are short well-commented scripts that I've written to support my research activities. The scripts are primarily focused on enabling the expert bench researcher to generate and manipulate nucleic acid sequences as well as prepare, execute, and analyze NGS experiments from start to finish (while learning some Python in the process).

The scripts are run from the command line in Terminal (Mac, PC, Linux). If this is new to you, don't worry. I've written a simple guide (see Tutorial_1_getting_started.md) that will get you up and running in 30 minutes or less even if you've never used the command line before. All of the Python (.py) and bash (.sh) scripts are run as follows:

1. Open your preferred command line terminal application.
2. At the command line prompt, enter the following and press enter:

    > /path/to/script/<script filename> argument_1 argument_2 argument_3 ... argument_n

The "arguments" could be DNA sequences, chromosome coordinates, or some customizable options you want to tell the script to use.  Read the script header for instructions.

Many of these tools rely on excellent tools that others have created and will be listed in the script header or the import section below it. If you've already learned how to use pip or conda or you've read Tutorial_1_getting_started.md, then you know what to do.

Feel free to use, modify, repurpose, and stitch them together with others to make the scripts you need. And please let me know if you catch a bug. :)

Scripts

> dna-seq.sh

Bash script for a no-frills DNA-seq workflow to create BAM files from FASTQ files.

> fetch-fastq.sh

Bash script to download NCBI SRA runs as FASTQ files.

> fetch-sequence.py

Python script to fetch the reference sequence from the UCSC Genome Browser for given a chromosome name, start and stop coordinate, and hg build. 

> reverse-complement.py

Python script to convert a given nucleic acid sequence into its reverse complement. Non-ATCG characters are accepted.
