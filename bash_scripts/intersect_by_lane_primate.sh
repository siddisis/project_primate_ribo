#!/bin/bash
## this program intersect each lane of data with orthoexon annotation for each species to get read count per gene for checking replication between lanes
##to run program do: bash intersect_by_lane_primate.sh species (H , C or R) outfolder

species=$1
outfolder=$2
EXONS="/mnt/lustre/data/users/cusanovich/References/${species}.MetaOrthoExons.master.bed"
##CEXONS="/mnt/lustre/data/users/cusanovich/References/C.MetaOrthoExons.master.bed"
##REXONS="/mnt/lustre/data/users/cusanovich/References/R.MetaOrthoExons.master.bed"
bedtools=$(echo "/mnt/lustre/home/cusanovich/Programs/BEDTools/bin/")
combineExonCount=$(echo "/mnt/lustre/data/users/cusanovich/New_HCR_RNAseq/exoncombiner.py")
mkdir ${outfolder}

for ID in ${species}*
do
for file in ${ID}/*.sort.bam
do
filename=$(echo "${file}" | sed 's/\//\t/g' | cut -f 2)
##intersect for individual exons
${bedtools}coverageBed -abam $file -b $EXONS > ${outfolder}/${filename}.exoncounts.txt
##combine counts for ortho_genes
python ${combineExonCount} ${outfolder}/${filename}.exoncounts.txt ${outfolder}/${filename}.genecounts.txt;
done
done
exit
