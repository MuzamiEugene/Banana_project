#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N diamond_blastp_prot-m
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=48:00:00
#PBS -m abe
#PBS -M georgekitundu2@gmail.com

eval "$(conda shell.bash hook)"

conda activate diamond


diamond blastp \
 -q /mnt/lustre/users/maloo/euMwanza/dataset/prtn-m.fasta \
 -d /mnt/lustre/users/maloo/euMwanza/ncbi_db/nr \
 -o /mnt/lustre/users/maloo/euMwanza/diamond_results/prtn-m.daa \
 --ultra-sensitive \
 -f 100

