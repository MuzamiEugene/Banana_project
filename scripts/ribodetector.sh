#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N detecting_rRNA_DATA_3
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=8:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

eval "$(conda shell.bash hook)" 
conda activate ribodetector

##DATA LOCATION
data1_1=/mnt/lustre/users/maloo/euMwanza/dataset/S1_S1_L001_R1_001.fastq.gz
data1_2=/mnt/lustre/users/maloo/euMwanza/dataset/S1_S1_L001_R2_001.fastq.gz
data3_1=/mnt/lustre/users/maloo/euMwanza/dataset/D_1.fastq.gz
data3_2=/mnt/lustre/users/maloo/euMwanza/dataset/D_2.fastq.gz
data2_1=/mnt/lustre/users/maloo/euMwanza/dataset/S2_S1_L001_R1_001.fastq.gz
data2_2=/mnt/lustre/users/maloo/euMwanza/dataset/S2_S1_L001_R2_001.fastq.gz
out_folder=/mnt/lustre/users/maloo/euMwanza/riboDetector_analysis
 
ribodetector_cpu  -t 48 \
  -l 151 \
  -i $data3_1 $data3_2 \
  -e norrna \
  --chunk_size 256 \
  --log $out_folder/data3/D3.log \
  -r $out_folder/data3/D3_reads.rRNA.R1.fq $out_folder/data3/D3_reads.rRNA.R2.fq \
  -o $out_folder/data3/D3_reads.nonrrna.R1.fq $out_folder/data3/D3_reads.nonrrna.R2.fq

# ribodetector_cpu -t 48 \
#   -l 120 \
#   -i $data1_1 $data1_2 \
#   -e norrna \
#  --chunk_size 256 \
#   --log $out_folder/data1/D1.log \
#   -r $out_folder/data1/D1_reads.rRNA.R1.fq $out_folder/data1/D1_reads.rRNA.R2.fq \
#   -o $out_folder/data1/D1_reads.nonrrna.R1.fq $out_folder/data1/D1_reads.nonrrna.R2.fq

# ribodetector_cpu -t 48 \
#   -l 120 \
#   -i $data2_1 $data2_2 \
#   -e norrna \
#    --chunk_size 256 \
#   --log $out_folder/data2/D2.log \
#   -r $out_folder/data2/D2_reads.rRNA.R1.fq $out_folder/data2/D2_reads.rRNA.R2.fq \
#   -o $out_folder/data2/D2_reads.nonrrna.R1.fq $out_folder/data2/D2_reads.nonrrna.R2.fq
