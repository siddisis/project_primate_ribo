#!/bin/sh

###this program makse read intersect with start codon annotations for human, chimp and Rhesus
##to run this program do bash startCodon_intersect.sh in the merged bam file folder

##specise=$1
Hstart="/mnt/lustre/home/siddisis/downloads/hg19_gene_annotation_BED_files/hg19_100bp_flanking_start_codon_plus_strand_average_100way.phastCons_greater_than_9_uniq_bed6.bed"
Cstart="/mnt/lustre/home/siddisis/downloads/hg19_gene_annotation_BED_files/hg19_100bp_flanking_start_codon_plus_strand_average_100way.phastCons_greater_than_9_liftover_to_PanTro3_uniq_bed6.bed"
Rstart="/mnt/lustre/home/siddisis/downloads/hg19_gene_annotation_BED_files/hg19_100bp_flanking_start_codon_plus_strand_average_100way.phastCons_greater_than_9_liftover_to_RheMac2_uniq_bed6.bed"
##start=$(echo "${specise}start")
bedtools="/mnt/lustre/home/siddisis/bin/BEDTools-Version2.8/bin"
rp_table="/mnt/lustre/home/siddisis/data/riboPro/sort_by_sampleID/april_7_mergeBam/relative_position.table"

for file in H*_uniquely_mapped_reads.bam
do
${bedtools}/intersectBed -abam $file -b $Hstart -s -bed -wa -wb | cut -f 2,8 | sed 's/\t/\-/g'| bc | grep -w -f $rp_table | grep -v "-" | sort | uniq -c | join -a1 -e -t\  -j1 1 -j2 2 $rp_table - > ${file%%_uniquely_mapped_reads.bam}_aggregate_reads_count_at_start_codon_flanking.txt
done

for file in C*_uniquely_mapped_reads.bam
do
${bedtools}/intersectBed -abam $file -b $Cstart -s -bed -wa -wb | cut -f 2,8 | sed 's/\t/\-/g'| bc | grep -w -f $rp_table | grep -v "-" | sort | uniq -c | join -a1 -e -t\  -j1 1 -j2 2 $rp_table - > ${file%%_uniquely_mapped_reads.bam}_aggregate_reads_count_at_start_codon_flanking.txt
done

for file in R*_uniquely_mapped_reads.bam
do
${bedtools}/intersectBed -abam $file -b $Rstart -s -bed -wa -wb | cut -f 2,8 | sed 's/\t/\-/g'| bc | grep -w -f $rp_table | grep -v "-" | sort | uniq -c | join -a1 -e -t\  -j1 1 -j2 2 $rp_table - > ${file%%_uniquely_mapped_reads.bam}_aggregate_reads_count_at_start_codon_flanking.txt
done

#cat $rp_table > merge_count_at_start_codon.table
for file in *_aggregate_reads_count_at_start_codon_flanking.txt
do
sname=${file%%_aggregate_reads_count_at_start_codon_flanking.txt}
#lanename=`echo $lane | sed 's/\///g'`
#dir_name=${file%%/*aggregate_reads_count_at_start_codon_flanking.table}
echo "a ${sname}" > sampleID.txt
awk '{ print $2 }' sampleID.txt $file > ${sname}_reads_count_at_start_codon.table
done
paste *reads_count_at_start_codon.table > merge_count_at_start_codon.table
rm *reads_count_at_start_codon.table
rm *reads_count_at_start_codon_flanking.txt
echo "RP" | cut -f1 - $rp_table | paste - merge_count_at_start_codon.table > aggregate_read_count_at_phastCon_9_start_codon.table


exit
