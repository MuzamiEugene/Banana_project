#!/bin/bash
#PBS -l select=4:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N Train_naive_bayes_classifier_V3_V4_16S-GSR-DB
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=16:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

eval "$(conda shell.bash hook)"

conda activate qiime2-amplicon-2024.2

#DATA LOCATION
REF_READS=/mnt/lustre/users/maloo/euMwanza/dataset/GSR-DB-training-data-for-QIIME2/GSR-DB_V3_V4/GSR-DB_V3-V4_cluster-1_seqs.qza
REF_TAXONOMY=/mnt/lustre/users/maloo/euMwanza/dataset/GSR-DB-training-data-for-QIIME2/GSR-DB_V3_V4/GSR-DB_V3-V4_cluster-1_taxa.qza
OUT_CLASSIFIER=/mnt/lustre/users/maloo/euMwanza/dataset/GSR-DB-training-data-for-QIIME2/GSR-DB_V3_V4


##TRAINING THE CLASSIFIER
qiime feature-classifier fit-classifier-naive-bayes \
  --i-reference-reads $REF_READS \
  --i-reference-taxonomy $REF_TAXONOMY \
  --o-classifier $OUT_CLASSIFIER/GSR-DB_V3_V4_cluster-1_classifier.qza
