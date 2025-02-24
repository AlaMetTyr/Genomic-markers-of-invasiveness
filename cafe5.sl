#!/bin/bash -e

#SBATCH --job-name=Orthofinder_invasomics # job name (shows up in the queue)
#SBATCH --time=3-00:00:00      # Walltime (HH:MM:SS)
#SBATCH --mem=50GB          # Memory in MB
#SBATCH --account=name/here

##run Cafe5
/nesi/project/ga03488/software/CAFE5/bin/cafe5 -i filtered_cafe_input.txt -t Species_Tree/SpeciesTree_rooted_node_labels.tre.ultrametric.tre
