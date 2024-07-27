#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N barplot_visualizing_taxonomy_results_data1_2
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=16:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

eval "$(conda shell.bash hook)"
conda activate qiime2-amplicon-2024.2

CLASSIFIED_TAXA_DIR=/mnt/lustre/users/maloo/euMwanza/dataset/qiime_data_import/taxonomy_clasification/data1_2/p_confidence_disable
METADATA_DIR=/mnt/lustre/users/maloo/euMwanza/scripts/
FEATURE_TABLE_DIR=/mnt/lustre/users/maloo/euMwanza/dataset/qiime_data_import/denoising/data_1_n_2
OUT_DIR=/mnt/lustre/users/maloo/euMwanza/dataset/qiime_data_import/taxonomy_clasification/data1_2/taxonomy_visualisation

qiime taxa barplot \
--i-table $FEATURE_TABLE_DIR/16S-table.qza \
--i-taxonomy $CLASSIFIED_TAXA_DIR/16S-rep-seqs_taxonomy.qza \
--m-metadata-file $METADATA_DIR/data1_2_metadata.tsv \
--o-visualization $OUT_DIR/data1_2_sample_barplots.qzv