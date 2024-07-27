#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N visualizing_taxonomy_results_data1_2
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=16:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

eval "$(conda shell.bash hook)"
conda activate qiime2-amplicon-2024.2

CLASSIFIER=/mnt/lustre/users/maloo/euMwanza/dataset/GSR-DB-training-data-for-QIIME2/GSR-DB_V3_V4
REP_SEQS=/home/maloo/lustre/euMwanza/dataset/qiime_data_import/denoising/data_1_n_2/16S-rep-seqs.qza
OUT_TAXONOMY=/home/maloo/lustre/euMwanza/dataset/qiime_data_import/taxonomy_clasification/data1_2

# qiime feature-classifier classify-sklearn \
#   --i-classifier  $CLASSIFIER/GSR-DB_V3_V4_cluster-1_classifier.qza \
#   --i-reads $REP_SEQS \
#   --o-classification $OUT_TAXONOMY/16S-rep-seqs_taxonomy.qza \
#   --p-confidence disable

qiime metadata tabulate \
  --m-input-file $OUT_TAXONOMY/16S-rep-seqs_taxonomy.qza \
  --o-visualization $OUT_TAXONOMY/16S-rep-seqs_taxonomy.qzv