#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N detecting_rRNA_DATA3
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=8:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

eval "$(conda shell.bash hook)" 
conda activate RiboTaxa_py27
conda activate RiboTaxa_py36

module load chpc/BIOMODULES
module load usearch 
