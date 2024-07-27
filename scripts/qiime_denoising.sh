#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N data1_2_denoising_summarizing_and_visualisation
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=08:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

#Author: GEORGE KITUNDU
#Date: 14-March-2024
#Location: Pwani University-PUBREC
#Most of the script was adopted from the tutoria for QIIME2:
#https://bioinfo.ird.fr/index.php/tutorials-fr/qiime2-in-command-line/#:~:text=Option%20with%20a%20manifest%20file,%2Dfilepath%22%20to%20the%20fastq.

eval "$(conda shell.bash hook)"

conda activate qiime2-amplicon-2024.2

#FILE LOCATIONS
QZA_FILE_DIR=/mnt/lustre/users/maloo/euMwanza/dataset/qiime_data_import/
OUTPUT_QIIME_DENOISE=/mnt/lustre/users/maloo/euMwanza/dataset/qiime_data_import/denoising/
METADATA_DIR=/mnt/lustre/users/maloo/euMwanza/scripts

#STEP 2: Following data importation the next step is denoising the data

#Based on the quality information and presence of primers the different p-trim and p-trunc 
#parameters need to be changed. they are specific to each study and primers. Here we have forward 
#primers of 19 bp and reverse of 20 bp. The total amplicon length is 251 bp, based on the qzv visualization
# we decide on the truncation length (p-trunc-len) of the forward and reverse reads. You can change the number 
#of threads on the server with p-n-threads. This command will generate 3 files: the OTU table (16S-table.qza),the
#representative sequence fasta file (16S-rep-seqs.qza) and denoising statistic file (16S-denoising-stats.qza)

##DENOISING USING DADA2
# qiime dada2 denoise-paired \
#   --i-demultiplexed-seqs $QZA_FILE_DIR/data1_2/data1_2_paired-end-demux.qza \
#   --p-n-threads 48 \
#   --p-trunc-len-f 150 \
#   --p-trunc-len-r 150 \
#   --o-table $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-table.qza \
#   --o-representative-sequences $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-rep-seqs.qza \
#   --o-denoising-stats $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-denoising-stats.qza \
#   --p-trim-left-f 19 \
#   --p-trim-left-r 20 \

##SUMMARY FILE AND VISUALIZING DENOISING FILES
qiime metadata tabulate \
  --m-input-file $OUTPUT_QIIME_DENOISE/data_1_n_2/16S-denoising-stats.qza \
  --o-visualization $OUTPUT_QIIME_DENOISE/data_1_n_2/16S-denoising-stats.qzv

qiime feature-table summarize \
  --i-table $OUTPUT_QIIME_DENOISE/data_1_n_2/16S-feature_table_samoles.qza \
  --o-visualization $OUTPUT_QIIME_DENOISE/data_1_n_2/16S-feature_table_samoles.qzv \
  --m-sample-metadata-file $METADATA_DIR/data1_2_metadata.tsv

qiime feature-table tabulate-seqs \
  --i-data $OUTPUT_QIIME_DENOISE/data_1_n_2/16S-rep-seqs.qza \
  --o-visualization $OUTPUT_QIIME_DENOISE/data_1_n_2/16S-rep-seqs.qzv

##DENOISING USING DEBLUR INCASE OF LOW NUMBER OF READS BUT ALSO ITS FASTER
##FIRST MERGE SINCE DEBLUR CANT SUPPORT PAIRED END
# qiime vsearch merge-pairs \
#      --i-demultiplexed-seqs $QZA_FILE \
#      --o-merged-sequences $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-MERGED-reads.qza \
#      --o-unmerged-sequences $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-UNMERGED-reads.qza \
#      --p-threads 48

##THEN PERFROM Sequence quality control and feature table construction
# qiime quality-filter q-score \
#       --i-demux $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-MERGED-reads.qza \
#       --o-filtered-sequences $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-MERGED-filtered.qza \
#       --o-filter-stats $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-MERGED-filter-stats.qza

##DENOISE WITH DEBLUR
# qiime deblur denoise-16S \
#       --i-demultiplexed-seqs $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-MERGED-filtered.qza \
#       --p-trim-length 151 \
#       --p-sample-stats \
#       --p-jobs-to-start 48 \
#       --o-stats $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-MERGED-filtered-deblur-stats.qza \
#       --o-representative-sequences $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-MERGED-filtered-rep-seqs-deblur.qza \
#       --o-table $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-MERGED-filtered-table-deblur.qza


##VSISUALIZE THE RESULTS  FOR THE DEBLUR DENOISING STEP

# qiime deblur visualize-stats \
#        --i-deblur-stats $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-MERGED-filtered-deblur-stats.qza \
#        --o-visualization $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-MERGED-filtered-deblur-stats.qzv

# qiime feature-table tabulate-seqs \
#        --i-data $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-MERGED-filtered-rep-seqs-deblur.qza \
#        --o-visualization $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-MERGED-filtered-rep-seqs-deblur.qzv

# qiime feature-table summarize \
#        --i-table $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-MERGED-filtered-table-deblur.qza \
#        --m-sample-metadata-file metadata.tsv \
#        --o-visualization $OUTPUT_QIIME_DENOISE/data3_rRNA_paired-end-demux-MERGED-filtered-table-deblur.qzv