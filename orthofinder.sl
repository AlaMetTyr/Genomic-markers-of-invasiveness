#!/bin/bash -e

#SBATCH --job-name=Orthofinder_invasomics # job name (shows up in the queue)
#SBATCH --time=3-00:00:00      # Walltime (HH:MM:SS)
#SBATCH --mem=50GB          # Memory in MB
#SBATCH --account=name/here

module purge
module load OrthoFinder/2.5.2-gimkl-2020a-Python-3.8.2


for f in *.faa
do 
  orthofinder -f ./${f%.faa} 
done

