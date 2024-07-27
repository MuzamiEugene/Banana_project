#!/bin/bash
#PBS -l select=3:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N full_picrust2_pipeline_qiime2
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=08:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

eval "$(conda shell.bash hook)"
conda activate qiime2-amplicon-2024.2

QZA_FILE_DIR=/mnt/lustre/users/maloo/euMwanza/dataset/qiime_data_import/
OUTPUT_QIIME_DENOISE=/mnt/lustre/users/maloo/euMwanza/dataset/qiime_data_import/denoising/
METADATA_DIR=/mnt/lustre/users/maloo/euMwanza/scripts
REFERENCE_GSR_V3_V4_DB=/mnt/lustre/users/maloo/euMwanza/dataset/GSR-DB-training-data-for-QIIME2/GSR-DB_V3_V4
GREENGENES_DB=/mnt/lustre/users/maloo/euMwanza/dataset/greenGenes_13_8/gg_13_8_otus
FUNC_PREDICTION_OUTPUT=/mnt/lustre/users/maloo/euMwanza/dataset/qiime_data_import/functional_prediction


qiime picrust2 full-pipeline \
   --i-table $OUTPUT_QIIME_DENOISE/mammal_biom.qza \
   --i-seq mammal_seqs.qza \
   --output-dir q2-picrust2_output \
   --p-placement-tool epa-ng \
   --p-threads 72 \
   --p-hsp-method mp \
   --p-max-nsti 2 \
   --verbose