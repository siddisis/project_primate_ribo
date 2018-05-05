#!/bin/bash
## make data matrix genes by row lane by column 
for file in *quality.sort.bam.genecounts.txt
do 
sample_name=${file%%-fc-*quality.sort.bam.genecounts.txt}
echo "${sample_name}" > tempt.txt
sed '1d' $file | cut -f5 tempt.txt - > ${file}_readCount.txt
done
paste *_readCount.txt > ReadCount_by_lane.table
rm tempt.txt
rm *_readCount.txt

## need to add row label back (ESGID)
cut -f4 $file > ENSGID.txt
paste ENSGID.txt ReadCount_by_lane.table > ReadCount_by_lane_gene_label.table
rm ENSGID.txt
exit
