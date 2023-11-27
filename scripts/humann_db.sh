#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -N humman_db-download
#PBS -q normal
#PBS -P CBBI1470
#PBS -l walltime=8:00:00
#PBS -m abe
#PBS -M eugeemwanza04@gmail.com

eval "$(conda shell.bash hook)"
conda activate Humann3

humann_databases --download utility_mapping full /mnt/lustre/users/maloo/euMwanza/humann3_db/ --update-config yes
humann_databases --download uniref uniref90_diamond /mnt/lustre/users/maloo/euMwanza/humann3_db/ --update-config yes
humann_databases --download chocophlan full /mnt/lustre/users/maloo/euMwanza/humann3_db/chocophlan/ --update-config yes

#getting the above databases from the default servers failed, they were obtained from the folowing link via wget
#http://cmprod1.cibio.unitn.it/
#information about updates can be found here:
#https://forum.biobakery.org/t/release-notes-for-humann-3-0-0-and-chocophlan-201901b/2544
#the information on how to update humann3 config to point out the location of the upggraded databases were done
#based on the information in this link: https://forum.biobakery.org/t/difficulty-downloading-databases-in-humann3/1343/7
#as shown below:
tar xzvf <filename>
humann_config --update database_folders nucleotide <path>