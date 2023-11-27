#!/bin/bash
#PBS -l select=4:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N data3_taxonomic_kaiju_analysis_nr_euk
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=12:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

module load chpc/BIOMODULES

module load kaiju/1.9.2


# Input and output files
INPUT_FASTQ_R1=/mnt/lustre/users/maloo/euMwanza/data3_filtering_results/out.D_1.fastq.gz
INPUT_FASTQ_R2=/mnt/lustre/users/maloo/euMwanza/data3_filtering_results/out.D_2.fastq.gz
OUTPUT_FILE=/mnt/lustre/users/maloo/euMwanza/kaiju_analysis_output/

# Paths to database files
##FUNGI_DB
FUNGI_TAXONOMY_NODES=/mnt/lustre/users/maloo/euMwanza/kaiju_db/fungi_db/nodes.dmp
FUNGI_KAIJU_INDEX=/mnt/lustre/users/maloo/euMwanza/kaiju_db/fungi_db/kaiju_db_fungi.fmi

##NR_EUK_DB
NR_EUK_TAXONOMY_NODES=/mnt/lustre/users/maloo/euMwanza/kaiju_db/nr_euk_db/nodes.dmp
NR_EUK_INDEX=/mnt/lustre/users/maloo/euMwanza/kaiju_db/nr_euk_db/kaiju_db_nr_euk.fmi

##PLASMIDS_DB
PLASMIDS_TAXONOMY_NODES=/mnt/lustre/users/maloo/euMwanza/kaiju_db/plasmids_db/nodes.dmp
PLASMIDS_INDEX=/mnt/lustre/users/maloo/euMwanza/kaiju_db/plasmids_db/kaiju_db_plasmids.fmi

##REFSEQ_DB
REFSEQ_TAXONOMY_NODES=/mnt/lustre/users/maloo/euMwanza/kaiju_db/refseq_db/nodes.dmp
REFSEQ_INDEX=/mnt/lustre/users/maloo/euMwanza/kaiju_db/refseq_db/kaiju_db_refseq.fmi

##REFSEQ_NR_DB
REFSEQ_NR_TAXONOMY_NODES=/mnt/lustre/users/maloo/euMwanza/kaiju_db/refseq_nr_db/nodes.dmp
REFSEQ_NR_INDEX=/mnt/lustre/users/maloo/euMwanza/kaiju_db/refseq_nr_db/kaiju_db_refseq_nr.fmi

##REFSEQ_REF_DB
REFSEQ_REF_TAXONOMY_NODES=/mnt/lustre/users/maloo/euMwanza/kaiju_db/refseq_ref_db/nodes.dmp
REFSEQ_REF_INDEX=/mnt/lustre/users/maloo/euMwanza/kaiju_db/refseq_ref_db/kaiju_db_refseq_ref.fmi

##RVDB
RVDB_TAXONOMY_NODES=/mnt/lustre/users/maloo/euMwanza/kaiju_db/rvdb/nodes.dmp
RVDB_INDEX=/mnt/lustre/users/maloo/euMwanza/kaiju_db/rvdb/kaiju_db_rvdb.fmi

# # Run Kaiju for taxonomic classification
# ##FUNGI_DB
# kaiju \
# -z 70 \
# -t $FUNGI_TAXONOMY_NODES \
# -f $FUNGI_KAIJU_INDEX \
# -i $INPUT_FASTQ_R1 \
# -j $INPUT_FASTQ_R2 \
# -o $OUTPUT_FILE/data3_kaiju/data3_kaiju_analysis_FUNGI_DB.out

##NR_EUK_DB
kaiju \
-z 70 \
-t $NR_EUK_TAXONOMY_NODES \
-f $NR_EUK_INDEX \
-i $INPUT_FASTQ_R1 \
-j $INPUT_FASTQ_R2 \
-o $OUTPUT_FILE/data3_kaiju/data3_kaiju_analysis_NR_EUK_DB.out

# ##PLASMIDS_DB
# kaiju \
# -z 70 \
# -t $PLASMIDS_TAXONOMY_NODES \
# -f $PLASMIDS_INDEX \
# -i $INPUT_FASTQ_R1 \
# -j $INPUT_FASTQ_R2 \
# -o $OUTPUT_FILE/data3_kaiju/data3_kaiju_analysis_PLASMIDS_DB.out

# ##REFSEQ_DB
# kaiju \
# -z 70 \
# -t $REFSEQ_TAXONOMY_NODES \
# -f $REFSEQ_INDEX \
# -i $INPUT_FASTQ_R1 \
# -j $INPUT_FASTQ_R2 \
# -o $OUTPUT_FILE/data3_kaiju/data3_kaiju_analysis_REFSEQ_DB.out

##REFSEQ_NR_DB

# kaiju \
# -z 70 \
# -t $REFSEQ_NR_TAXONOMY_NODES \
# -f $REFSEQ_NR_INDEX \
# -i $INPUT_FASTQ_R1 \
# -j $INPUT_FASTQ_R2 \
# -o $OUTPUT_FILE/data3_kaiju/data3_kaiju_analysis_REFSEQ_NR_DB.out

# ##REFSEQ_REF_DB
# kaiju \
# -z 70 \
# -t $REFSEQ_REF_TAXONOMY_NODES \
# -f $REFSEQ_REF_INDEX \
# -i $INPUT_FASTQ_R1 \
# -j $INPUT_FASTQ_R2 \
# -o $OUTPUT_FILE/data3_kaiju/data3_kaiju_analysis_REFSEQ_REF_DB.out

# ##RVDB
# kaiju \
# -z 70 \
# -t $RVDB_TAXONOMY_NODES \
# -f $RVDB_INDEX \
# -i $INPUT_FASTQ_R1 \
# -j $INPUT_FASTQ_R2 \
# -o $OUTPUT_FILE/data3_kaiju/data3_kaiju_analysis_RVDB.out



