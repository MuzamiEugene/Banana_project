
#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N prodigal_prediction_megahit2
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=8:00:00
#PBS -m abe
#PBS -M eugenemwanza04@gmail.com

#eval "$(conda shell.bash hook)"

#conda activate fastp
#removal of adapters and quality filtering
#fastp -i /mnt/lustre/users/maloo/euMwanza/dataset/D_1.fastq.gz -I /mnt/lustre/users/maloo/euMwanza/dataset/D_2.fastq.gz \
#-o /mnt/lustre/users/maloo/euMwanza/filtering_results/out.D_1.fastq.gz \
#-O /mnt/lustre/users/maloo/euMwanza/filtering_results/out.D_2.fastq.gz

module add chpc/BIOMODULES
#module load megahit/1.2.9
module load prodigal/2.6.3
#module load spades/3.14.1

#performing genome assembly

#megahit --presets meta-large --k-min 27 --kmin-1pass --k-step 10 \
#-1 /mnt/lustre/users/maloo/euMwanza/filtering_results/out.D_1.fastq.gz \
#-2 /mnt/lustre/users/maloo/euMwanza/filtering_results/out.D_2.fastq.gz \
#-o /mnt/lustre/users/maloo/euMwanza/megahit2_assembly/data3.megahit.assm

#spades.py --meta -t 48 \
#-1 /mnt/lustre/users/maloo/euMwanza/filtering_results/out.D_1.fastq.gz \
#-2 /mnt/lustre/users/maloo/euMwanza/filtering_results/out.D_2.fastq.gz \
#-o /mnt/lustre/users/maloo/euMwanza/spades_assembly_data3/

#performing gene prediction

prodigal -i /mnt/lustre/users/maloo/euMwanza/megahit2_assembly/data3.megahit.assm/final.contigs.fa \
-o /mnt/lustre/users/maloo/euMwanza/gp_report2/D3.gff \
-a /mnt/lustre/users/maloo/euMwanza/gp_report2/D3.faa \
-d /mnt/lustre/users/maloo/euMwanza/gp_report2/D3.fna \
-p meta

#construction of non redudant gene catalogs

#cd-hit -i ./gp_report/D3.faa -o ./nr_catalogs/D3_gene_catalogs.fasta -c 0.95 -M 8000 -T 0 -g 1
