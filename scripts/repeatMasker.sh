#!/bin/bash
#PBS -l select=4:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N repeatMasker_mtDNA_to_NEW_SN3_NUCLEAR
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=08:00:00
#PBS -m abe
#PBS -M georgekitundu2@gmail.com

module load chpc/BIOMODULES
module load RepeatMasker/4.1.2-p1
# module load RepeatMasker/4.0.7

mtDNA_UNIQ_LIB=/home/maloo/lustre/euMwanza/blast-George/repeatMasker/SN3_NEW__assembly/mtDNA/S.n_UNIQ_mtDNA.fa
APICOPLAST_REPEAT_LIB=/mnt/lustre/users/maloo/euMwanza/blast-George/repeatMasker/apicoplast_SN3/SN3_apicoplast.fasta
SN3_NUCLEAR_OLD=/mnt/lustre/users/maloo/euMwanza/blast-George/repeatMasker/SN3_old_assembly_DB/ToxoDB-67_SneuronaSN3_ONLY_Genome.fasta
SN3_NUCLEAR_NEW=/home/maloo/lustre/euMwanza/blast-George/repeatMasker/SN3_NEW__assembly/SN3_NUC_only_genome.fa

# # The following scripts masks the old SN3 nuclear genome of the  SN3 APocoplast
# RepeatMasker -pa 120 -s -a -inv -small -html -source -gff -nolow \
#     -e rmblast \
#     -lib $APICOPLAST_REPEAT_LIB \
#     $SN3_NUCLEAR_OLD 


# The following scripts masks the old SN3 nuclear genome of the  SN3 Apicoplast
RepeatMasker -pa 96 -s -a -inv -small -html -source -gff -nolow \
    -e rmblast \
    -lib $mtDNA_UNIQ_LIB \
    $SN3_NUCLEAR_NEW 



