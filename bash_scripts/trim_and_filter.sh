#!/bin/bash

## define input argument

file_path=$1

dir_name=$(echo $file_path | sed 's/\//\,/g' | cut -d , -f 1) 
fname=$(echo $file_path | sed 's/\//\,/g' | cut -d , -f 2) 



#### trim and cut

#zcat $file_path | /mnt/lustre/home/siddisis/bin/fastx_clipper -a AGATCGGAAGAGCACAC -l 22 -c -n –v | /mnt/lustre/home/siddisis/bin/fastx_trimmer -f 2 > $dir_name/${fname}_trimmed.fq

zcat $file_path | /mnt/lustre/home/siddisis/bin/fastx_clipper -a AGATCGGAAGAGCACAC -l 22 -c -n –v -o $dir_name/${fname}_clipped.fq
/mnt/lustre/home/siddisis/bin/fastx_trimmer -f 2 -i $dir_name/${fname}_clipped.fq -o $dir_name/${fname}_trimmed.fq
rm $dir_name/${fname}_clipped.fq


## filter out rRNA_tRNA_snoRNA reads


/mnt/lustre/home/siddisis/bin/bowtie2 --phred64 --seedlen=20 --un=$dir_name/${fname}_filtered.fq /mnt/lustre/home/siddisis/downloads/rRNA_tRNA_snoRNA_fasta/rRNA_tRNA_snoRNA $dir_name/${fname}_trimmed.fq -S $dir_name/${fname}_rRNA_tRNA_snoRNA.sam

rm $dir_name/${fname}_rRNA_tRNA_snoRNA.sam
rm $dir_name/${fname}_trimmed.fq
exit
