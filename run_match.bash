#$ -cwd 
#$ -S /bin/bash
#$ -e logs
#$ -o logs 
#$ -N match
#$ -l h_vmem=12G 

export ROSETTA3_DB=/share/tmp-data-1/siegellab/Rosetta/main/database/
export PATH=/share/tmp-data-1/siegellab/Rosetta/main/source/bin/:$PATH

s=$( awk 'NR=="'${SGE_TASK_ID}'" { print $1 }' scaffold_list.txt ) 

for i in RBO SBO OXI; do 
  for j in HW_HW HW_YTS YTS_YTS; do 

echo match.linuxgccrelease -s input_pdb/$s.pdb -match:geometric_constraint_file cst/match/${i}_${j}.cst -extra_res_fa params/${i}.params input_params/${s}.params -match:lig_name $i -match:scaffold_active_site_residues input_pos/$s.pos -ex1 -ex2 -ex1aro -ex2aro -output_format PDB -consolidate_matches -out:path:all match_out -ignore_unrecognized_res 1 -match_grouper SameSequenceGrouper
