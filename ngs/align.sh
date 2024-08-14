#!/bin/bash

# Define your working folder
DIR=/ceph/work/IBMS-HHChenLab/2024_workshop/genomic03
/bin/mkdir -p $DIR

# Define your reference genome
REF=$DIR/ngs/hg38.chr20.fa
# Define your reads
READ1=$DIR/ngs/HG00403.chr20.5m_1.fq.gz
READ2=$DIR/ngs/HG00403.chr20.5m_2.fq.gz

#Define TOOLS###
BWA=$DIR/tools/bwa/bwa
SAMTOOLS=$DIR/tools/samtools/samtools

# Define your output folder
OUT_DIR=$DIR/ngs/output
/bin/mkdir -p $DIR/ngs/output

# Index reference genome
$BWA index $REF
# Align reads against reference
$BWA mem -R '@RG\tID:HG00403_1\tSM:HG00403\tPL:ILLUMINA' $REF $READ1 $READ2 \
  | $SAMTOOLS view -bS -o $OUT_DIR/align.bam

# Sort and index BAM file
$SAMTOOLS sort $OUT_DIR/align.bam -o $OUT_DIR/align.sorted.bam
$SAMTOOLS index $OUT_DIR/align.sorted.bam
