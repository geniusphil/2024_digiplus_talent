#!/bin/bash

DIR=/ceph/work/IBMS-HHChenLab/2024_workshop/genomic03
REF=$DIR/ngs/hg38.chr20.fa
OUT_DIR=$DIR/ngs/output
BAM=$OUT_DIR/align.sorted.bam

GATK=$DIR/tools/gatk/gatk-package-4.2.6.1-local.jar
###CreateSequenceDictionary###
#/usr/bin/java -Xmx256m -jar $GATK CreateSequenceDictionary \
#	-R $REF -O $DIR/ngs/hg38.chr20.dict

###SAMTOOLS###
SAMTOOLS=$DIR/tools/samtools/samtools
$SAMTOOLS faidx $REF

###ValidateSamFile###
#/usr/bin/java -Xmx256m -jar $GATK ValidateSamFile \
#	-R $REF \
#	-I $BAM

###MarkDuplicates###
#/usr/bin/java -Xmx256m -jar $GATK MarkDuplicates \
#	-I $BAM \
#	-M $OUT_DIR/align.sorted.marked_dup_metrics.txt \
#	-O $OUT_DIR/align.sorted.duplicates.bam

###BQSR###
/usr/bin/java -Xmx256m -jar $GATK BaseRecalibrator \
	-I $OUT_DIR/align.sorted.duplicates.bam \
	-R $REF \
	--known-sites $DIR/ngs/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz \
	-O $OUT_DIR/recalibration_report.grp

/usr/bin/java -Xmx256m -jar $GATK ApplyBQSR \
	-I $OUT_DIR/align.sorted.duplicates.bam \
	-R $REF	\
	--bqsr-recal-file $OUT_DIR/recalibration_report.grp \
	-O $OUT_DIR/align.sorted.duplicates.recal.bam

###CALLING###
/usr/bin/java -jar -Xmx256m $GATK HaplotypeCaller \
	-I $OUT_DIR/align.sorted.duplicates.recal.bam \
	-R $REF \
	-ERC GVCF \
	-O $OUT_DIR/gatk.g.vcf

###Genotype###
/usr/bin/java -jar -Xmx256m $GATK GenotypeGVCFs \
	-R $REF \
	-V $OUT_DIR/gatk.g.vcf \
	-O $OUT_DIR/gatk.vcf
