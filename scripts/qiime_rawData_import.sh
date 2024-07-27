#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N data1_2_qiime2_data_import
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=04:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

#Author: GEORGE KITUNDU
#Dtae: 14-March-2024
#Location: Pwani University-PUBREC
#Most of the script was adopted from the tutoria for QIIME2:
#https://bioinfo.ird.fr/index.php/tutorials-fr/qiime2-in-command-line/#:~:text=Option%20with%20a%20manifest%20file,%2Dfilepath%22%20to%20the%20fastq.



eval "$(conda shell.bash hook)"
conda activate qiime2-amplicon-2024.2
# conda activate qiime2-shotgun-2024.2 


#FILE LOCATIONS
MANIFEST_FILE_DIR=/mnt/lustre/users/maloo/euMwanza/scripts/
OUTPUT_QIIME_IMPORT_DIR=/mnt/lustre/users/maloo/euMwanza/dataset/qiime_data_import

##LOCATION FOR DATA3 KAIJU MODIFIED OTU TABLE FOR BACTERIA ONLY
DATA3_MODIFIED_OTU_TABLE=/mnt/lustre/users/maloo/euMwanza/kaiju_analysis_output/all_classification_summary/nr_euk

##this is for kaiju data3 modified bacteria OTU json.biom  convert
##Since qiime cannot accept csv or tsv, convert to tsv then convet to biom
# sed 's/,/\t/g' OTU_bacteriamodified.csv > OTU_bacteriamodified.tsv

##then
# biom convert -i OTU_bacteriamodified.tsv -o OTU_bacteriamodified.json.biom --table-type "OTU table" --to-json

##then run qiime import feature data
qiime tools import \
--type 'FeatureTable[Frequency]' \
--input-path $DATA3_MODIFIED_OTU_TABLE/OTU_bacteriamodified.json.biom \
--input-format BIOMV100Format \
--output-path  $DATA3_MODIFIED_OTU_TABLE/OTU_bacteriamodified_table.qza 


##this is for 16s data
#STEP 1: IMPORT RAW DATA INTO QIIME2 format
qiime tools import \
--type 'SampleData[PairedEndSequencesWithQuality]' \
--input-path $MANIFEST_FILE_DIR/manifest_data1_2.tsv \
--input-format PairedEndFastqManifestPhred33V2 \
--output-path $OUTPUT_QIIME_IMPORT_DIR/data1_2/data1_2_paired-end-demux.qza 


  # ##VISUALIZING THE .QZA file by converitng to .qzv
  # qiime demux summarize \
  # --i-data $OUTPUT_QIIME_IMPORT/data1_2_paired-end-demux.qza \
  # --o-visualization $OUTPUT_QIIME_IMPORT/data1_2_paired-end-demux.qzv
