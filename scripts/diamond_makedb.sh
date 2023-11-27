#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N diamond_makedb
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=48:00:00
#PBS -m abe
#PBS -M georgekitundu2@gmail.com

eval "$(conda shell.bash hook)"

conda activate diamond

diamond makedb --in /mnt/lustre/users/maloo/euMwanza/ncbi_db/nr.gz -d /mnt/lustre/users/maloo/euMwanza/ncbi_db/nr
