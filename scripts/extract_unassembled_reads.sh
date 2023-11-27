#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N megahit_extract_unassembled_step3
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=8:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

module add chpc/BIOMODULES
module load bbmap/38.95
module load samtools/1.17 

#bbwrap.sh ref=/mnt/lustre/users/maloo/euMwanza/megahit2_assembly/data3.megahit.assm/final.contigs.fa \
#in=/mnt/lustre/users/maloo/euMwanza/filtering_results/out.D_1.fastq.gz \
#in2=/mnt/lustre/users/maloo/euMwanza/filtering_results/out.D_2.fastq.gz \
#out=/mnt/lustre/users/maloo/euMwanza/megahit2_assembly/unassembled_reads/aln.sam.gz \
#kfilter=28 \
#subfilter=15 \
#maxindel=80

#pileup.sh in=/mnt/lustre/users/maloo/euMwanza/megahit2_assembly/unassembled_reads/aln.sam.gz \
#out=/mnt/lustre/users/maloo/euMwanza/megahit2_assembly/unassembled_reads/cov.txt

samtools view -u -f4 \
/mnt/lustre/users/maloo/euMwanza/megahit2_assembly/unassembled_reads/aln.sam.gz  \
| samtools bam2fq -s/mnt/lustre/users/maloo/euMwanza/megahit2_assembly/unassembled_reads/unmapped.se.fq \
- > /mnt/lustre/users/maloo/euMwanza/megahit2_assembly/unassembled_reads/unmapped.pe.fq

