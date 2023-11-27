#!/usr/bin/env bash

eval "$(conda shell.bash hook)"

conda activate biobakery4

DB_FOLDER=/mnt/lustre/users/maloo/euMwanza/humann_uniref
humann_databases --download uniref uniref50_diamond $DB_FOLDER