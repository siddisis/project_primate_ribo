## make data matrix genes by row individuals by column 
for file in *genecounts.txt 
do 
s_name=${file%%.genecounts.txt}
echo "${s_name}" > tempt.txt
sed 1d $file | cut -f5 tempt.txt - > ${file}_readCount.txt
rm tempt.txt
done
paste *_readCount.txt > mergeReadCount.table
rm *_readCount.txt


## need to add row label back (ESGID)

cut -f4 $file > ENSGID.txt
cut -f6 $file > Genelength.txt
paste ENSGID.txt Genelength.txt mergeReadCount.table > mergeReadCount_gene_label.table
rm ENSGID.txt
rm Genelength.txt
exit
