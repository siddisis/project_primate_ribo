#!/bin/bash
## this program merges bam files by individual for all directories with specified species in the dir name in mergeBAM folder run fasqc and intersect for read count per gene
##to run program do: bash merge_bam_and_intersect.sh species (H , C or R) outfolder
#need to mkdir mergeBAM first
species=$1
outfolder=$2
EXONS="/mnt/lustre/data/users/cusanovich/References/${species}.MetaOrthoExons.master.bed"
##CEXONS="/mnt/lustre/data/users/cusanovich/References/C.MetaOrthoExons.master.bed"
##REXONS="/mnt/lustre/data/users/cusanovich/References/R.MetaOrthoExons.master.bed"
QC=$(echo "/mnt/lustre/home/siddisis/bin/FastQC/fastqc")
bedtools=$(echo "/mnt/lustre/home/cusanovich/Programs/BEDTools/bin/")
combineExonCount=$(echo "/mnt/lustre/data/users/cusanovich/New_HCR_RNAseq/exoncombiner.py")
##merge bam files across flow lanes and run fastQC on the merge bam
mkdir ${outfolder}
for ID in ${species}*
do
samtools merge ${outfolder}/${ID}_uniquely_mapped_reads.bam ${ID}/*sort.bam
${QC} ${outfolder}/${ID}_uniquely_mapped_reads.bam
##intersect for individual exons
${bedtools}coverageBed -abam ${outfolder}/${ID}_uniquely_mapped_reads.bam -b $EXONS > ${outfolder}/${ID}.exoncounts.txt
##combine counts for ortho_genes
python ${combineExonCount} ${outfolder}/${ID}.exoncounts.txt ${outfolder}/${ID}.genecounts.txt;
done
exit
