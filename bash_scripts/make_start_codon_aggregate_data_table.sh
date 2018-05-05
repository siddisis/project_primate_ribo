#!/bin/bash
for file in */*aggregate_reads_count_at_start_codon_flanking.table
do 
lane=${file%%aggregate_reads_count_at_start_codon_flanking.table}
lanename=`echo $lane | sed 's/\///g'`
dir_name=${file%%/*aggregate_reads_count_at_start_codon_flanking.table}
echo "${dir_name}" > tempt.txt
cut -f2 tempt.txt $file > ${lanename}_aggregate_reads_count_at_start_codon.txt
done
paste *count_at_start_codon.txt > merge_count_at_start_codon.table
rm *count_at_start_codon.txt
echo "RP" | cut -f1 - relative_position.table | paste - merge_count_at_start_codon.table > aggregate_reads_count_at_start_codon_by_lane.table
rm tempt.txt
exit
