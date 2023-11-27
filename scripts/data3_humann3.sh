#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N data3_humann3_analysis_optimized
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=16:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

eval "$(conda shell.bash hook)"

conda activate biobakery4

##taxonomic and functional profiling with humann3
humann --threads 48 --output-basename data3 \
--metaphlan-options="--stat_q 0.15 --unclassified_estimation" \
--translated-subject-coverage-threshold 0.0 \
--nucleotide-subject-coverage-threshold 0.0 \
--bowtie-options=“–very-sensitive-local” \
--nucleotide-query-coverage-threshold 50.0 \
--translated-query-coverage-threshold 50.0 \
--input /mnt/lustre/users/maloo/euMwanza/data3_filtering_results/D_filt_concat.fastq \
--output /mnt/lustre/users/maloo/euMwanza/data3_humann3/optimized