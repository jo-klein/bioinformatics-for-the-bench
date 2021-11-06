#!/bin/bash

# dna-seq.sh
# Joshua Klein 11-06-2021

# This script processes a set of fastq files for DNA-seq
# and outputs deduped BAM and BAIs file for further
# analysis. Additional outputs include multiqc reports in
# HTMl for pre- and post-adapter trimming.

# Usage
#   1. Save the fastq files in an empty directory.
#   2. Navigate to the directory from the terminal command line.
#   3. Type the following at the prompt and press enter:
#     > dna-seq.sh /path/to/fastq/files/ /path/to/ref/genome/ -p -j <#> -l -e
#   Note final forward slashes at the ends of the paths.

# Optional flags
#  -s Process single read fastqs (default: paired-end)
#  -j <integer> Number of threads to use during alignment (default: 1)
#  -l Inserts are almost all > ~70 bp (default: yes)

# Example
#     > ./dna-seq.sh ./ ../ref/hg38_no_alt -j 4
# This will look for all unique fastq.gz file names in the current
# working directory and align *1.fastq.gz and *2.fastq.gz to human
# reference genome build hg38 using 4 threads and assumes inserts are
# almost all > ~70 bp.

# Dependencies
# - fastqc
# - multiqc
# - trim_galore
# - bwa
# - samtools

# References
# - https://stackoverflow.com/questions/17232526/how-to-pass-an-array-argument-to-the-bash-script

DIR=$1
REF=$2
shift 2

# Process optional flags
while getopts 'sj:le:' flag; do
    case "${flag}" in
        s ) s=1             ;; # Process as single read fastqs
        j ) j="${OPTARG}"   ;; # Use multiple cores for alignment
        l ) l=1             ;; # Inserts are almost entirely < ~70 bp
    esac
done

# Store all fastq file names and gzip if not already
shopt -s nullglob # Set array to empty if no fastq files found
FILES=("${DIR}"*.fastq)
echo "${FILES[@]}"
if [ $((${#FILES[@]})) -gt 0 ]; then
    for i in ${FILES[@]}; do gzip $i; done # gzip uncompressed files
fi

# Function to create multiqc report
getMultiqc(){
    local FILES=("${!1}") # Create local array of FILES - see reference
    for i in ${FILES[@]}; do
        f_i="${i##*/}"; echo "Analyzing ${f_i}"
        fastqc $i &> /dev/null # Run fastqc on each file
    done
    multiqc $2 -n $3 -o $2 # Combine into single report
    rm $2*_*_$4; rm $2*_*_$5 # Remove single report files
    echo
}  

# Step 1. Create pre-trim multiqc report
echo "Step 1 of 4 - pre-trim multiqc"
FILES=("${DIR}"*.fastq.gz)
getMultiqc "FILES[@]" "$DIR" "pre_trim" "fastqc.html" "fastqc.zip"

# Step 2. Run trim_galore
echo "Step 2 of 4 - trim fastqs"
for i in $(seq 0 ${s:-2} $((${#FILES[@]}-1))); do
    # If paired-end, get second trimmed filename
    if [ ${s:-2} -eq 2 ]; then 
        f="${FILES[$i]} ${FILES[$i+1]}"
        p="--paired"
    else
        f="${FILES[$i]}"
        p=""; fi
    echo "Trimming $(basename ${FILES[$i]%%_*})"
    trim_galore $p --cores ${j:-1} -o ${DIR} $f
done

# Step 3. Create post-trim multiqc report
echo "Step 3 of 4 - post-trim multiqc"
FILES=($DIR*.fq.gz) # Store list of trimmed files
getMultiqc "FILES[@]" "$DIR" "post_trim" "fastqc.html" "fastqc.zip"

echo "Step 4 of 4 - align to ref genome and create indexed bam"
for i in $(seq 0 ${s:-2} $((${#FILES[@]}-1))); do
    f=${FILES[$i]%%_*}
    echo "Aligning and indexing $(basename $f)"
    if [ ${l:-0} -eq 0 ]; then # Reads are > ~70 bp
        if [ ${s:-2} -eq 2 ]; then bwa mem -t ${j:-1} ${REF} ${FILES[$i]} ${FILES[$i+1]} > $f.sam
        else bwa mem -t ${j:-1} ${REF} ${FILES[$i]} > $f.sam; fi
    else # Reads are < ~70 bp
        if [ ${s:-2} -eq 2 ]; then
            bwa aln -t ${j:-1} ${REF} ${FILES[$i]} ${FILES[$i+1]} > $f.1.sai $f.2.sai
            bwa sampe ${REF} $f.1.sai $f.2.sai ${FILES[$i]} ${FILES[$i+1]} > $f.sam
        else
            bwa aln -t ${j:-1} ${REF} ${FILES[$i]} > $f.1.sai
            bwa sampe ${REF} $f.1.sai ${FILES[$i]} > $f.sam
        fi
    fi
    samtools sort -O bam -o - -T $f.tmp $f.sam | \
        samtools collate -o - - | \
            samtools fixmate -m - - | \
            samtools sort -o - - | \
                samtools markdup -rs - $f.dedup.bam
    samtools index $f.dedup.bam
    rm $f*.fq.gz
done

echo
echo "Process complete"
echo
