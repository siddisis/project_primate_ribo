## make data matrix exons by row individuals by column 
for file in *.exoncounts.txt
do 
s_name=${file%%.exoncounts.txt}
echo "${s_name}" > tempt.txt
cut -f5 tempt.txt $file > ${file}_readCount.txt
rm tempt.txt
done
paste *_readCount.txt > mergeReadCount.table
rm *_readCount.txt


## need to add row label back (ESGID)
echo "ID" > tempt.txt
cut -f4 tempt.txt $file > ENSGID.txt
rm tempt.txt
echo "length" > tempt.txt
cut -f7 tempt.txt $file > Genelength.txt
rm tempt.txt
paste ENSGID.txt Genelength.txt mergeReadCount.table > mergeReadCount_exon_label.table
rm ENSGID.txt
rm Genelength.txt
exit
