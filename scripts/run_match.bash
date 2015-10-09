#$ -S /bin/bash
#$ -e /home/carlin/boxi/logs/
#$ -o /home/carlin/boxi/logs/
#$ -N match

export ROSETTA3_DB=/share/tmp-data-1/siegellab/Rosetta/main/database/
export PATH=/share/tmp-data-1/siegellab/Rosetta/main/source/bin/:$PATH
cd /home/carlin/boxi 

s=$( awk 'NR=="'${SGE_TASK_ID}'" { print $1 }' list/match_in.txt ) 
i=$( awk 'NR=="'${SGE_TASK_ID}'" { print $2 }' list/match_in.txt )
j=$( awk 'NR=="'${SGE_TASK_ID}'" { print $3 }' list/match_in.txt )

match.linuxgccrelease \
  -s pdb/$s.pdb \
  -match:geometric_constraint_file cst/match/${i}_${j}.cst \
  -extra_res_fa params/ligand/${i}.params params/cofactor/${s}.params \
  -match:lig_name $i \
  -match:scaffold_active_site_residues pos/${s}.pos \
  -ex1 -ex2 -ex1aro -ex2aro \
  -output_format PDB \
  -consolidate_matches 1 \
  -match_grouper SameSequenceGrouper \
  -output_matches_per_group 1 \

mv UM* out/match/
