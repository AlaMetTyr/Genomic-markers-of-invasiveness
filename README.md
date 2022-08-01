# Identifying traits of invasiveness
Analaysing reference genomes of invasive and non-invasive insect species to replicate the DIGS paper protocol by Huang et al 2020.


## Downloading genomic data from NCBI
Whole genome assembly data for each of the assigned invasive and non-invasive species was downloaded from the NCBI GenBank database as .tar files.
tar files were unpacked in bulk using the command `for filename in ./*.tar; do tar -xvf "${filename}"; done` followed by `gunzip *.gz` to get a .fna file. 
.fna files were then converted to .fa files using the command `mv *.fna *.fa'.

Sequencing data downloaded for this shown below:

-	Diptera(Fly)	*Drosophila pseudoobscura*	GCA_000001765.2	GCF_000001765.3
-	Hymenoptera	*Apis mellifera*	GCA_000002195.1	GCF_000002195.4
-	Hemiptera	*Acyrthosiphon pisum*	GCA_000142985.2	GCF_000142985.2
-	Lepidoptera	*Bombyx mori*	GCA_000151625.1	GCF_000151625.1
-	Hymenoptera	*Apis florea*	GCA_000184785.1	GCF_000184785.2
-	Hymenoptera	*Solenopsis invicta*	GCA_000188075.1	GCF_000188075.1
-	Hymenoptera	*Bombus impatiens*	GCA_000188095.2	GCF_000188095.1
-	Hymenoptera	*Bombus terrestris*	GCA_000214255.1	GCF_000214255.1
-	Hymenoptera	*Linepithema humile*	GCA_000217595.1	GCF_000217595.1
-	Hymenoptera	*Megachile rotundata*	GCA_000220905.1	GCF_000220905.1
-	Diptera(Fly)	*Drosophila biarmipes*	GCA_000233415.2	GCF_000233415.1
-	Lepidoptera	*Plutella xylostella*	GCA_000330985.1	GCF_000330985.1
-	Hymenoptera	*Cephus cinctus*	GCA_000341935.1	GCF_000341935.1
-	Diptera(Fly)	*Ceratitis capitata*	GCA_000347755.2	GCF_000347755.3
-	Coleoptera	*Anoplophora glabripennis*	GCA_000390285.1	GCF_000390285.2
-	Hymenoptera	*Microplitis demolitor*	GCA_000572035.2	GCF_000572035.2
-	Hymenoptera	*Ooceraea biroi*	GCA_000611835.1	GCF_000611835.1
-	Hymenoptera	*Copidosoma floridanum*	GCA_000648655.1	GCF_000648655.2
-	Hemiptera	*Cimex lectularius* 	GCA_000648675.1	GCF_000648675.1
-	Hemiptera	*Halyomorpha halys*	GCA_000696795.1	GCF_000696795.1
-	Coleoptera	*Agrilus planipennis*	GCA_000699045.1	GCF_000699045.1
-	Diptera(Fly)	*Bactrocera dorsalis*	GCA_000789215.2	GCF_000789215.1
-	Diptera(Fly)	*Bactrocera cucurbitae*	GCA_000806345.1	GCF_000806345.1
-	Lepidoptera	*Papilio polytes*	GCA_000836215.1	GCF_000836215.1
-	Lepidoptera	*Papilio Xuthus*	GCA_000836235.1	GCF_000836235.1
-	Hymenoptera	*Vollenhovia emeryi*	GCA_000949405.1	GCF_000949405.1
-	Hymenoptera	*Wasmannia auropunctata*	GCA_000956235.1	GCF_000956235.1
-	Lepidoptera	*Amyelois transitella*	GCA_001186105.1	GCF_001186105.1
-	Hemiptera	*Diuraphis noxia*	GCA_001186385.1	GCF_001186385.1
-	Hymenoptera	*Polistes dominula*	GCA_001465965.1	GCF_001465965.1
-	Diptera(Fly)	*Bactrocera latifrons*	GCA_001853355.1	GCF_001853355.1
-	Hemiptera	*Bemisia tabaci*	GCA_001854935.1	GCF_001854935.1
-	Lepidoptera	*Pieris rapae*	GCA_001856805.1	GCF_001856805.1
-	Diptera(Mosquito)	*Aedes albopictus*	GCA_001876365.2	GCF_001876365.2
-	Lepidoptera	*Helicoverpa armigera*	GCA_002156985.1	GCF_002156985.1
-	Diptera(Mosquito)	*Aedes aegypti*	GCA_002204515.1	GCF_002204515.2
-	Lepidoptera	*Spodoptera litura*	GCA_002706865.1	GCF_002706865.1

Expanded dataset of .fa an d annotatoins fo further speciers with no invasive classification/ low N50 were also downloade dand stored for later use.

## Genome characteristics
Size of repeat elements were recorded. Repeatmasker and appropriate libraries were installed locally following insstrucitons found here: https://www.repeatmasker.org/RepeatMasker/ 
before using the `perl RepeatMasker *.fa` command. 


## OrthoFinder
OrthoFinder was used as module on NeSI cluster to identify single copy orthologous genes and correspond to the DIGS paper.

`orthofinder -f ./` #runs orthofinder on default settings for proteinfasta files
Further options are useful if starting analysis using already determined BLAST data or OrthoFinder output files.

  `-fg` Start analysis from orthogroups OrthoFinder directory

  `-ft` Start analysis from gene trees in OrthoFinder directory

  `-M msa` Use MSA gene tree inference


#Filtering and parsing output for input into cafe5.
the orthogroups file must be manipulated to remove the total genes and include a description column before exporting as a text file for filtering.

Removing gene families with large copy gene number variance: (from cafe5 tools file)
`./clade_and_size_filter.py -i ./Orthogroups/Orthogroups2.txt -o filtered_cafe_input.txt -s`

Making the species tree generated ultrametric: (additional tool availble form OrthoFinder github. If using Orthofinder as a module requires the download of 'scripts_of' file form orthoinder main directory.
`python make_ultrametric.py Species_Tree/SpeciesTree_rooted_node_labels.tre` 

## Running Cafe5
cafe5 uses input ofOrthoFinder orthogroups file and an ultrametric tree to analyze change in gene family sie that accounts for phylogenetic history within the clade.

`/nesi/project/ga03488/software/CAFE5/bin/cafe5 -i filtered_cafe_input.txt -t Species_Tree/SpeciesTree_rooted_node_labels.tre.ultrametric.tre`

Average distance from root to leaves: 0.526572
Lambda: 0.8573758077929

## Filtering the data based on largest and smallest expansion/ contraction indexes

`gawk  'BEGIN{FS=OFS=","}NR>1{for(i=1;i<=25;i++)printf $i ","; print $26}' full_cafe_species.tab.csv > sampleInv.csv`

## Initial ML predictions using WEKA
Weka is a collection of machine learning algorithms for data mining from the Computing and Mathematical Sciences department at Waikato University.
