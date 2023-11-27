#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N data2_assembly_prodigal
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=8:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

module add chpc/BIOMODULES
# module load megahit/1.2.9
module load prodigal/2.6.3
# module load spades/3.14.1
# module load bbmap/38.95

# eval "$(conda shell.bash hook)"

# conda activate fastp

# removal of adapters and quality filtering
# fastp \
# -i /mnt/lustre/users/maloo/euMwanza/dataset/S2_S1_L001_R1_001.fastq.gz \
# -I /mnt/lustre/users/maloo/euMwanza/dataset/S2_S1_L001_R2_001.fastq.gz \
# -o /mnt/lustre/users/maloo/euMwanza/data2_filtering_results/S2_S1_L001_R1_001.filt.fastq.gz \
# -O /mnt/lustre/users/maloo/euMwanza/data2_filtering_results/S2_S1_L001_R2_001.filt.fastq.gz \
# --failed_out /mnt/lustre/users/maloo/euMwanza/data2_filtering_results/failed.fq \
# -h /mnt/lustre/users/maloo/euMwanza/data2_filtering_results/

# assembly via megahit
# megahit --presets meta-large --k-min 27 --kmin-1pass --k-step 10 \
# -1 /mnt/lustre/users/maloo/euMwanza/data2_filtering_results/S2_S1_L001_R1_001.filt.fastq.gz \
# -2 /mnt/lustre/users/maloo/euMwanza/data2_filtering_results/S2_S1_L001_R2_001.filt.fastq.gz  \
# -o /mnt/lustre/users/maloo/euMwanza/megahit_data2_assembly/data2.megahit.assm

#performing gene prediction

prodigal -i /mnt/lustre/users/maloo/euMwanza/megahit_data2_assembly/data2.megahit.assm/final.contigs.fa \
-o /mnt/lustre/users/maloo/euMwanza/data2_assembly_gp_report/data2_assembly.gff \
-a /mnt/lustre/users/maloo/euMwanza/data2_assembly_gp_report/data2_assembly.faa \
-d /mnt/lustre/users/maloo/euMwanza/data2_assembly_gp_report/data2_assembly.fna \
-p meta