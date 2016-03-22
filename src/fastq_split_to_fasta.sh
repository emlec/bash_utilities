#!/bin/bash

#########################################################################
# Emilie Lecomte							#
# 22/03/2016								#
#									#
# This script converts a fastq file into one or several fasta file(s)	#
# Input : .fastq							#
# Output :  .fasta file(s) 						#
# Command line : bash fastq_split_to_fasta.sh				#
#########################################################################


# Get input

echo "Enter the name of the fastq file to convert"
read fastqFile

# Retrieve the name without path and extension (several "." possible)

fullName=$fastqFile
fileName=$(basename "$fullName")
name=$(echo $fileName | cut -d '.' -f1)
echo "The file name is" $name

# Convert fastq file to fasta file

gunzip -c $fastqFile | paste - - - -  | cut -f 1,2 | sed 's/^@/>/' | tr "\t" "\n" > $name.fasta


# Option : Split the fasta file into several fasta files
 
echo "Do you want to split the fasta file into separates files (y/n)?"
read answer

if [ "$answer" == "y" ]; then csplit -f Seq $name.fasta '/>/' {*}   # TODO replace the name of fasta file by the header
else echo "No split"
fi 
echo "END"

gzip *.fasta




