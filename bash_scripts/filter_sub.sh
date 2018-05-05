#!/bin/bash
##mkdir err
for fname in */*.fastq.gz
do
dir_name=$(echo $fname | sed 's/\//\,/g' | cut -d , -f 1) 
file_name=$(echo $fname | sed 's/\//\,/g' | cut -d , -f 2) 
if [ ! -f ${dir_name}/${file_name}_filtered.fq ]
                        then
    echo " bash scripts/trim_and_filter.sh $fname " | qsub -l h_vmem=16g  -wd `pwd` -o err/${dir_name}_${file_name}_filter.out -e err/${dir_name}_${file_name}_filter.err
fi 
done
exit
