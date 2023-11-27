#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N data3_metaphlan_analysis
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=8:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com


eval "$(conda shell.bash hook)"

conda activate biobakery4

##taxonomic and functional profiling with metaphlan
metaphlan \
/mnt/lustre/users/maloo/euMwanza/data3_filtering_results/out.D_1.fastq.gz,\
/mnt/lustre/users/maloo/euMwanza/data3_filtering_results/out.D_2.fastq.gz \
--input_type fastq \
--bowtie2out /mnt/lustre/users/maloo/euMwanza/data3_metaphlan_profiling/data3_metagenome.bowtie2.bz2 \
--nproc 48 \
--unclassified_estimation \
-o /mnt/lustre/users/maloo/euMwanza/data3_metaphlan_profiling/data3_profiled_metagenome.txt