#!/bin/sh
for file in */*/fastqc_data.txt
do
lanename=$(echo ${file} | awk -F \/ '{print $2}' | sed 's/_fastqc//g')
touch cov/${lanename}_cov.txt
bash fastQC_parser.sh $file >> cov/${lanename}_cov.txt
cat */${lanename}.counts.txt | awk '{print $2}' | sed '/^$/d' >> cov/${lanename}_cov.txt
done
exit
