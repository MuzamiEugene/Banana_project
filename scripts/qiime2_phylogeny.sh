#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N data1_2_phylogeny
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=16:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

eval "$(conda shell.bash hook)"
conda activate qiime2-amplicon-2024.2

QIIME_DENOISE_DIR=/mnt/lustre/users/maloo/euMwanza/dataset/qiime_data_import/denoising/
PHYLOGENY_OUT_DIR=/mnt/lustre/users/maloo/euMwanza/dataset/qiime_data_import/


##PYLOGENETIC TREE
qiime phylogeny align-to-tree-mafft-fasttree \
--i-sequences $QIIME_DENOISE_DIR/data_1_n_2/16S-rep-seqs.qza \
--output-dir $PHYLOGENY_OUT_DIR/phylogenetic_tree \
--p-n-threads 48 

