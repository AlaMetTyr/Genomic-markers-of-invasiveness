#!/bin/bash -e

#SBATCH --job-name=Orthofinder_invasomics # job name (shows up in the queue)
#SBATCH --time=3-00:00:00      # Walltime (HH:MM:SS)
#SBATCH --mem=50GB          # Memory in MB
#SBATCH --account=name/here

##preprocess your orthofinder output for cafe5 format
cp path/to/your/input.csv output.txt head -1 input.txt | tr '\t' '\n' | nl ## identify the column number
awk -F'\t' '{ $28=""; print $0 }' OFS='\t' orthogroups.txt | sed 's/\t\t/\t/g' > orthogroups1.txt ## remove the column
awk -F'\t' 'BEGIN {OFS=FS} { $2="NULL\t"$2; print }' orthogroups1.txt > orthogroups2.txt ## add the description column
dos2unix orthogroups2.txt ##this is the input you now use for downstream filtering below

##Make sure you have downloaded the scripts_of folde from the orthofinder github
##filter your orthofinder output for gene families with gene copies in at least two species of the specified clades; separates gene families with < 100 from > 100 gene copies in one or more species
for f in /path/to/edited/orthofinder/output/*.txt
do python clade_and_size_filter.py -i ${f%.*}.txt -o output${f%.*}.txt
done


##Make the ultrametrix tree from your species tree
for f in /path/to/tree/file/*.tree
do python make_ultrametric.py ${f%.*}.txt
done
