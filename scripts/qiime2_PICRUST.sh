#!/bin/bash
#PBS -l select=3:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N PICRUST_step6_clustering_dereplicated_merges_seqs_to_greengenes
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

##STEP1
##WE BEGIN BY JOINING PAIRED END READS
# qiime vsearch merge-pairs \
# --i-demultiplexed-seqs $QZA_FILE_DIR/data1_2/data1_2_paired-end-demux.qza \
# --p-allowmergestagger \
# --o-merged-sequences $QZA_FILE_DIR/data1_2/data1_2_vsearch_merged_demux.qza \
# --o-unmerged-sequences $QZA_FILE_DIR/data1_2/data1_2_vsearch_unmerged_demux.qza

##STEP2
##Filter based on Q scores
# qiime quality-filter q-score \
# --i-demux $QZA_FILE_DIR/data1_2/data1_2_vsearch_merged_demux.qza \
# --o-filtered-sequences $QZA_FILE_DIR/data1_2/data1_2_mrgd_dmx_filt.qza \
# --o-filter-stats $QZA_FILE_DIR/data1_2/data1_2_mrgd_dmx_filt_stats.qza

##STEP3
##Dereplicating sequences
# qiime vsearch dereplicate-sequences \
# --i-sequences $QZA_FILE_DIR/data1_2/data1_2_mrgd_dmx_filt.qza \
# --o-dereplicated-table $QZA_FILE_DIR/data1_2/data1_2_mrgd_dmx_filt_drpl-tbl.qza \
# --o-dereplicated-sequences $QZA_FILE_DIR/data1_2/data1_2_mrgd_dmx_filt_drpl-seqs.qza 

##STEP4
##pricrust was trained with greengenes so we will use that as well
# wget ftp://greengenes.microbio.me/greengenes_release/gg_13_5/gg_13_8_otus.tar.gz
# tar -xvzf gg_13_8_otus.tar.gz

##STEP5
##import greengenes data to qiime
# qiime tools import \
# --type 'FeatureData[Sequence]' \
# --input-path $GREENGENES_DB/rep_set/97_otus.fasta \
# --output-path $GREENGENES_DB/rep_set/97_otus-GG.qza 


# qiime tools import \
# --type 'FeatureData[Taxonomy]' \
# --input-format HeaderlessTSVTaxonomyFormat \
# --input-path $GREENGENES_DB/taxonomy/97_otu_taxonomy.txt \
# --output-path $GREENGENES_DB/taxonomy/97_otu-ref-taxonomy-GG.qza 


##STEP 6
##do the OTU clustering at 97%
qiime vsearch cluster-features-closed-reference \
--i-table $QZA_FILE_DIR/data1_2/data1_2_mrgd_dmx_filt_drpl-tbl.qza \
--i-sequences $QZA_FILE_DIR/data1_2/data1_2_mrgd_dmx_filt_drpl-seqs.qza \
--i-reference-sequences $GREENGENES_DB/rep_set/97_otus-GG.qza \
--p-perc-identity 0.97 \
--o-clustered-table $FUNC_PREDICTION_OUTPUT/clustering/data1_2_mrgd_dmx_filt_drpl-tbl-cr-97.qza \
--o-clustered-sequences $FUNC_PREDICTION_OUTPUT/clustering/data1_2_mrgd_dmx_filt_drpl-seqs-cr-97.qza \
--o-unmatched-sequences $FUNC_PREDICTION_OUTPUT/clustering/data1_2_mrgd_dmx_filt_drpl-seqs_unmatched-cr-97_OSD14.qza


## Step7 Export the OTU table to biom format
qiime tools export \
--input-path $FUNC_PREDICTION_OUTPUT/clustering/data1_2_mrgd_dmx_filt_drpl-tbl-cr-97.qza \
--output-path $FUNC_PREDICTION_OUTPUT/clustering

##step8: convert biom format to json
biom convert \
-i $FUNC_PREDICTION_OUTPUT/clustering/feature-table.biom \
-o $FUNC_PREDICTION_OUTPUT/clustering/feature-table.json.biom \
--to-json
