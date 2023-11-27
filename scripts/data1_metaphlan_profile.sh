#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N data1_metaphlan_analysis2
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=8:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com


eval "$(conda shell.bash hook)"

#conda activate biobakery4
conda activate mpa4

##taxonomic and functional profiling with metaphlan
#DBDIR=/apps/chpc/bio/anaconda3-2020.02/envs/biobakery4/lib/python3.7/site-packages/metaphlan/metaphlan_databases/
DBDIR=/mnt/lustre/users/maloo/euMwanza/metaphlan_analysis2/metaphlan_db
metaphlan \
--bowtie2db  $DBDIR \
--stat_q 0.05 \
/mnt/lustre/users/maloo/euMwanza/data1_filtering_results/S1_S1_L001_R1_001.filt.fastq.gz,\
/mnt/lustre/users/maloo/euMwanza/data1_filtering_results/S1_S1_L001_R2_001.filt.fastq.gz \
--input_type fastq \
--bowtie2out /mnt/lustre/users/maloo/euMwanza/metaphlan_analysis2/data1_metaphlan_profiling/data1_metagenome.bowtie2.bz2 \
--nproc 48 \
--unclassified_estimation \
-o /mnt/lustre/users/maloo/euMwanza/metaphlan_analysis2/data1_metaphlan_profiling/data1_profiled_metagenome.txt