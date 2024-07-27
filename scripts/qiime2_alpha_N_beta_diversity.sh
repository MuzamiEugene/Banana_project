#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N test_for_differences_in_alpha_diversity
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=08:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

eval "$(conda shell.bash hook)"
conda activate qiime2-amplicon-2024.2

QIIME_DENOISE_DIR=/mnt/lustre/users/maloo/euMwanza/dataset/qiime_data_import/denoising/
PHYLOGENY_OUT_DIR=/mnt/lustre/users/maloo/euMwanza/dataset/qiime_data_import/
METADATA_4_RAREFACTION_DIR=/mnt/lustre/users/maloo/euMwanza/scripts
RAREFACTION_OUTPUT_DIR=/mnt/lustre/users/maloo/euMwanza/dataset/qiime_data_import/rarefaction
CORE_METRICS_OUT_DIR=/mnt/lustre/users/maloo/euMwanza/dataset/qiime_data_import/rarefaction

##LOCATION FOR DATA3 KAIJU MODIFIED OTU TABLE FOR BACTERIA ONLY
DATA3_MODIFIED_OTU_TABLE=/mnt/lustre/users/maloo/euMwanza/kaiju_analysis_output/all_classification_summary/nr_euk
DATA3_FEATURE_TABLE_KAIJU_QZA=/mnt/lustre/users/maloo/euMwanza/kaiju_analysis_output/all_classification_summary/nr_euk/alpha_rarefaction

##alpha diversity for data3 kaiju output
##alpha diversity for metrics 'pielou_e','shannon','observed_features' 
qiime diversity alpha \
--i-table $DATA3_FEATURE_TABLE_KAIJU_QZA/OTU_bacteriamodified_table.qza \
--p-metric 'observed_features' \
--o-alpha-diversity $DATA3_FEATURE_TABLE_KAIJU_QZA/data3_alpha-diversity_observed-features.qza 

##vizualize or check
qiime diversity alpha-group-significance \
  --i-alpha-diversity $DATA3_FEATURE_TABLE_KAIJU_QZA/data3_alpha-diversity_observed-features.qza \
  --m-metadata-file $DATA3_FEATURE_TABLE_KAIJU_QZA/metadata_mappingfile.txt \
  --o-visualization $DATA3_FEATURE_TABLE_KAIJU_QZA/alpha-group-sig-obs-feats.qzv

##alpha rarefaction(still trying to figure out for shotgun when it comes to phylogeny part)
qiime diversity alpha-rarefaction \
--i-table $DATA3_FEATURE_TABLE_KAIJU_QZA/OTU_bacteriamodified_table.qza \
--i-phylogeny  $PHYLOGENY_OUT_DIR/phylogenetic_tree/rooted_tree.qza  \
--p-max-depth  225541 \
--m-metadata-file $METADATA_4_RAREFACTION_DIR/data1_2_metadata.tsv \
--o-visualization $RAREFACTION_OUTPUT_DIR/alpha_rarefaction/data_1_2_rarefaction_225541.qzv


# # 16S rRNA dataset
# qiime diversity alpha-rarefaction \
# --i-table $QIIME_DENOISE_DIR/data_1_n_2/16S-feature_table_samoles.qza \
# --i-phylogeny  $PHYLOGENY_OUT_DIR/phylogenetic_tree/rooted_tree.qza  \
# --p-max-depth  225541 \
# --m-metadata-file $METADATA_4_RAREFACTION_DIR/data1_2_metadata.tsv \
# --o-visualization $RAREFACTION_OUTPUT_DIR/alpha_rarefaction/data_1_2_rarefaction_225541.qzv

# ##CORE PHYLOGENETICS METRICS COMBINED
# qiime diversity core-metrics-phylogenetic \
# --i-phylogeny $PHYLOGENY_OUT_DIR/phylogenetic_tree/rooted_tree.qza  \
# --i-table $QIIME_DENOISE_DIR/data_1_n_2/16S-feature_table_samoles.qza \
# --p-sampling-depth 225541 \
# --m-metadata-file $METADATA_4_RAREFACTION_DIR/data1_2_metadata.tsv \
# --output-dir $RAREFACTION_OUTPUT_DIR/core-metrics 

# test for differences in alpha diversity:

# Run plugin for each alpha diversity result
for result in $RAREFACTION_OUTPUT_DIR/core-metrics/*vector.qza; \
do \
outname=${result/_vector.qza/_group_significance.qzv}; \
qiime diversity alpha-group-significance \
--i-alpha-diversity $result \
--m-metadata-file $METADATA_4_RAREFACTION_DIR/data1_2_metadata.tsv \
--o-visualization $outname; \
# done

# ###BETA DIVERSITY
qiime diversity beta-rarefaction \
--i-table $QIIME_DENOISE_DIR/data_1_n_2/16S-feature_table_samoles.qza \
--p-metric weighted_unifrac \
--p-clustering-method nj \
--m-metadata-file $METADATA_4_RAREFACTION_DIR/data1_2_metadata.tsv \
--p-sampling-depth 225541 \
--i-phylogeny $PHYLOGENY_OUT_DIR/phylogenetic_tree/rooted_tree.qza \
--o-visualization $RAREFACTION_OUTPUT_DIR/beta_diversity/weighted_unifrac.qzv \
--verbose \
&> $RAREFACTION_OUTPUT_DIR/beta_diversity/beta_rarefaction.log