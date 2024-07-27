#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N CUTADAPT_ALL_DATA
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=8:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

#Author: GEORGE KITUNDU
#Date: Feb, 28, 2024

eval "$(conda shell.bash hook)"
conda activate cutadapt

#DATASET
dataset1_1=/home/maloo/lustre/euMwanza/dataset/S1_S1_L001_R1_001.fastq.gz
dataset1_2=/home/maloo/lustre/euMwanza/dataset/S1_S1_L001_R2_001.fastq.gz

dataset2_1=/home/maloo/lustre/euMwanza/dataset/S2_S1_L001_R1_001.fastq.gz
dataset2_2=/home/maloo/lustre/euMwanza/dataset/S2_S1_L001_R2_001.fastq.gz


##OUT_DIR
out_dir=/home/maloo/lustre/euMwanza/cutadapt_results

##DATA1
cutadapt \
-a GTGYCAGCMGCCGCGGTAA  \
-A GGACTACNVGGGTWTCTAAT \
-o $out_dir/S1_S1_L001_R1_001_cutAdapt.fastq.gz \
-p $out_dir/S1_S1_L001_R2_001.cutAdapt.fastq.gz \
$dataset1_1 \
$dataset1_2

##DATA2
cutadapt \
-a GTGYCAGCMGCCGCGGTAA  \
-A GGACTACNVGGGTWTCTAAT \
-o $out_dir/S2_S1_L001_R1_001_cutAdapt.fastq.gz \
-p $out_dir/S2_S2_L001_R1_001.cutAdapt.fastq.gz \
$dataset2_1 \
$dataset2_2