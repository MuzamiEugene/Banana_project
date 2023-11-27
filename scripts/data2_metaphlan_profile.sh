#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N data2_metaphlan_analysis
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=8:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com


eval "$(conda shell.bash hook)"

conda activate biobakery4

##taxonomic and functional profiling with metaphlan
metaphlan \
/mnt/lustre/users/maloo/euMwanza/data2_filtering_results/S2_S1_L001_R1_001.filt.fastq.gz,\
/mnt/lustre/users/maloo/euMwanza/data2_filtering_results/S2_S1_L001_R2_001.filt.fastq.gz \
--input_type fastq \
--stat_q 0.05 \
--bowtie2out /mnt/lustre/users/maloo/euMwanza/data2_metaphlan_profiling/data2_metagenome.bowtie2.bz2 \
--nproc 48 \
--unclassified_estimation \
-o /mnt/lustre/users/maloo/euMwanza/data2_metaphlan_profiling/data2_profiled_metagenome.txt