#!/bin/sh
## $1 is input file 

fname=$(echo ${1} | awk -F \/ '{print $2}' | sed 's/_uniquely_mapped_reads_fastqc//')
##get total reads
TR=$(awk '/Total Sequences/' $1 | awk '{print $3}')

##sum up reads pass Q30
Q30R=$(awk '/>>Per sequence quality scores/ , />>END_MODULE/' $1 |awk 'NR==31, NR==40' | awk '{print$2}'| paste -sd+|bc)

## amount of duplication level 2 
dup2=$(awk '/>>Sequence Duplication Levels/ , />>END_MODULE/' $1 | awk 'NR==5'| awk '{print $2;}')

## amount of duplication level 10++
dup10=$(awk '/>>Sequence Duplication Levels/ , />>END_MODULE/' $1 | awk 'NR==13'| awk '{print $2;}')


echo "${fname}"
##echo "total number of reads"
echo "$TR"
##echo "% pass Q30"
echo "${Q30R}/${TR}" | bc -l
##echo "sum of dup 2 and 10++"
echo "${dup2}+${dup10}" | bc
##echo "ratio of dup 2 over 10++"
echo "${dup2}/${dup10}" | bc -l
##echo ""

exit
