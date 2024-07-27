#!/bin/bash
#PBS -l select=1:ncpus=52:mpiprocs=52:mem=900gb
#PBS -P CBBI1470
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=48:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com
#PBS -N squeezemeta_data3_using_metspades_preassembled_scaffolds_restart -step10

eval "$(conda shell.bash hook)"
conda activate SqueezeMeta-1.6.3

##DATA LOCATIONS
RAW_DATA_DIR=/home/maloo/lustre/euMwanza/dataset/
OUTPUT_DIR=/home/maloo/lustre/euMwanza/squeezemeta_data3
SAMPLE_FILES=/mnt/lustre/users/maloo/euMwanza/scripts
EXTERNAL_ASSEMBLEY_SCAFFOLD=/mnt/lustre/users/maloo/euMwanza/metaSpades_assembly/data3_assm

## Squeezemeta on data3 sample using megahit
# SqueezeMeta.pl \
# -m sequential \
# -s $SAMPLE_FILES/data3.samples \
# -f $RAW_DATA_DIR/data3 \
# -a megahit \
# --assembly_options \
# "--presets meta-large --k-min 27 --kmin-1pass --k-step 10" \
# -binners maxbin,metabat2,concoct \
# -taxbinmode s+c \
# -D  -t 50 -b 110

##Squeezemeta using metaspades PREASSEMBLED scaffolds
SqueezeMeta.pl -p /home/maloo/D3_sample --restart --force_overwrite -step 10 \
-m sequential \
-s $SAMPLE_FILES/data3.samples \
-f $RAW_DATA_DIR/data3 \
-extassembly $EXTERNAL_ASSEMBLEY_SCAFFOLD/scaffolds.fasta \
-binners maxbin,metabat2,concoct \
-taxbinmode s+c \
-D  -t 50 -b 100


##read based since mappingstats were less than 30%
# sqm_reads.pl \
# -p D3_reads_based \
# -s $SAMPLE_FILES/data3.samples \
# -f $RAW_DATA_DIR/data3 \
# -t 52 -b 100