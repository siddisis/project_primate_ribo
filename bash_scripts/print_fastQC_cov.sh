#!/bin/sh
fastQC_parser=$(echo "/mnt/lustre/home/siddisis/data/riboPro/sort_by_sampleID/primates/scripts/fastQC_parser.sh")
for file in fastQCfiles/*/fastqc_data.txt
#_uniquely_mapped_reads_fastqc
do
s_name=$(echo ${file} | awk -F \/ '{print $2}' | sed 's/_uniquely_mapped_reads_fastqc//g')
touch cova/${s_name}_seq_quality_cova.txt
bash $fastQC_parser $file > cova/${s_name}_seq_quality_cova.txt
##cat */${s_name}.counts.txt | awk '{print $2}' | sed '/^$/d' >> cov/${lanename}_cov.txt
done
exit
