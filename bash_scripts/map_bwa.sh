HGENOME="/mnt/lustre/data/share/HCR_Chipseq/.Genomes_nb/hg19/hg19_norandom_noM_noY.fa"
CGENOME="/mnt/lustre/data/share/HCR_Chipseq/.Genomes_nb/panTro3/panTro3_nonrandom.fa"
RGENOME="/mnt/lustre/data/share/HCR_Chipseq/.Genomes_nb/rheMac2/softMask/rheMac2_norandom_noUr.fa"
DIR="/mnt/gluster/home/siddisis/ribopro/primates"
OUTDIR="/mnt/gluster/home/siddisis/ribopro/primates/err"
COUNTER="/mnt/lustre/home/siddisis/data/riboPro/mapping_script_test/sort_map_by_ind/libmix_5_4_1/monkeys/counters.txt"

## SPECIES=`ls $DIR | awk -v FS="-" '{print $1}'`

x=1
for NAME in `ls $DIR | grep H` # 106651 # 
	do
	for lane in `ls ${DIR}/${NAME}/*_filtered.fq`
		do
		LANE_NAME=`echo $lane | sed 's/.fastq.gz_filtered.fq//g'` # | sed 's/\//./g'`
   
		if [ ! -f ${LANE_NAME}.quality.sort.bam ]
			then
			echo "\
			/mnt/lustre/home/cusanovich/Programs/bwa/bwa aln -n 2 -t 3  ${HGENOME} ${lane} > ${LANE_NAME}.Ref.sai; \
			/mnt/lustre/home/cusanovich/Programs/bwa/bwa samse -n 1 ${HGENOME} ${LANE_NAME}.Ref.sai ${lane} > ${LANE_NAME}.Ref.sam; \
			rm ${LANE_NAME}.Ref.sai; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools view -S -h -q 10 -b ${LANE_NAME}.Ref.sam > ${LANE_NAME}.quality.bam ; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools view -S -h -f 4 -b ${LANE_NAME}.Ref.sam > ${LANE_NAME}.unmapped.bam ; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools sort ${LANE_NAME}.quality.bam ${LANE_NAME}.quality.sort; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools view -S -c ${LANE_NAME}.Ref.sam > ${LANE_NAME}.count.txt; \
			rm ${LANE_NAME}.quality.bam; \
			rm ${LANE_NAME}.Ref.sam; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools view -c ${LANE_NAME}.quality.sort.bam >> ${LANE_NAME}.count.txt; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools view -c ${LANE_NAME}.unmapped.bam >> ${LANE_NAME}.count.txt; \
			rm ${LANE_NAME}.unmapped.bam; \
			
			paste ${COUNTER} ${LANE_NAME}.count.txt > ${LANE_NAME}.counts.txt; \
			rm ${LANE_NAME}.count.txt" | qsub -l h_vmem=32g -o ${OUTDIR} -e ${OUTDIR} -wd `pwd` -N "map.${NAME}"
			x=$(( $x + 1 ))
		fi
		done
	done





for NAME in `ls $DIR | grep C` # 106651 #
 
	do
	for lane in `ls ${DIR}/${NAME}/*_filtered.fq`
		do
		LANE_NAME=`echo $lane | sed 's/.fastq.gz_filtered.fq//g'` # | sed 's/\//./g'`
   
		if [ ! -f ${LANE_NAME}.quality.sort.bam ]
			then
			echo "\
			/mnt/lustre/home/cusanovich/Programs/bwa/bwa aln -n 2 -t 3  ${CGENOME} ${lane} > ${LANE_NAME}.Ref.sai; \
			/mnt/lustre/home/cusanovich/Programs/bwa/bwa samse -n 1 ${CGENOME} ${LANE_NAME}.Ref.sai ${lane} > ${LANE_NAME}.Ref.sam; \
			rm ${LANE_NAME}.Ref.sai; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools view -S -h -q 10 -b ${LANE_NAME}.Ref.sam > ${LANE_NAME}.quality.bam ; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools view -S -h -f 4 -b ${LANE_NAME}.Ref.sam > ${LANE_NAME}.unmapped.bam ; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools sort ${LANE_NAME}.quality.bam ${LANE_NAME}.quality.sort; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools view -S -c ${LANE_NAME}.Ref.sam > ${LANE_NAME}.count.txt; \
			rm ${LANE_NAME}.quality.bam; \
			rm ${LANE_NAME}.Ref.sam; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools view -c ${LANE_NAME}.quality.sort.bam >> ${LANE_NAME}.count.txt; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools view -c ${LANE_NAME}.unmapped.bam >> ${LANE_NAME}.count.txt; \
			rm ${LANE_NAME}.unmapped.bam; \
			
			paste ${COUNTER} ${LANE_NAME}.count.txt > ${LANE_NAME}.counts.txt; \
			rm ${LANE_NAME}.count.txt" | qsub -l h_vmem=32g -o ${OUTDIR} -e ${OUTDIR} -wd `pwd` -N "map.${NAME}"
			x=$(( $x + 1 ))
		fi
		done
	done








for NAME in `ls $DIR | grep R` # 106651 #
 
	do
	for lane in `ls ${DIR}/${NAME}/*_filtered.fq`
		do
		LANE_NAME=`echo $lane | sed 's/.fastq.gz_filtered.fq//g'` # | sed 's/\//./g'`
   
		if [ ! -f ${LANE_NAME}.quality.sort.bam ]
			then
			echo "\
			/mnt/lustre/home/cusanovich/Programs/bwa/bwa aln -n 2 -t 3  ${RGENOME} ${lane} > ${LANE_NAME}.Ref.sai; \
			/mnt/lustre/home/cusanovich/Programs/bwa/bwa samse -n 1 ${RGENOME} ${LANE_NAME}.Ref.sai ${lane} > ${LANE_NAME}.Ref.sam; \
			rm ${LANE_NAME}.Ref.sai; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools view -S -h -q 10 -b ${LANE_NAME}.Ref.sam > ${LANE_NAME}.quality.bam ; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools view -S -h -f 4 -b ${LANE_NAME}.Ref.sam > ${LANE_NAME}.unmapped.bam ; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools sort ${LANE_NAME}.quality.bam ${LANE_NAME}.quality.sort; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools view -S -c ${LANE_NAME}.Ref.sam > ${LANE_NAME}.count.txt; \
			rm ${LANE_NAME}.quality.bam; \
			rm ${LANE_NAME}.Ref.sam; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools view -c ${LANE_NAME}.quality.sort.bam >> ${LANE_NAME}.count.txt; \
			/mnt/lustre/home/cusanovich/Programs/samtools/samtools view -c ${LANE_NAME}.unmapped.bam >> ${LANE_NAME}.count.txt; \
			rm ${LANE_NAME}.unmapped.bam; \
			
			paste ${COUNTER} ${LANE_NAME}.count.txt > ${LANE_NAME}.counts.txt; \
			rm ${LANE_NAME}.count.txt" | qsub -l h_vmem=32g -o ${OUTDIR} -e ${OUTDIR} -wd `pwd` -N "map.${NAME}"
			x=$(( $x + 1 ))
		fi
		done
	done








