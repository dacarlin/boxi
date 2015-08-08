#$ -S /bin/bash
#$ -e ~/boxi/logs
#$ -o ~/boxi/logs 
#$ -N match
#$ -l h_vmem=16G 

export ROSETTA3_DB=/share/tmp-data-1/siegellab/Rosetta/main/database/
export PATH=/share/tmp-data-1/siegellab/Rosetta/main/source/bin/:$PATH
cd ~/boxi 

s=$( awk 'NR=="'${SGE_TASK_ID}'" { print $1 }' list/scaffold.txt ) 

for i in RBO SBO OXI; do 
  for j in HW_HW HW_YTS YTS_YTS; do 
    echo match.linuxgccrelease \
      -s pdb/$s.pdb \
      -match:geometric_constraint_file cst/match/${i}_${j}.cst \
      -extra_res_fa params/ligand/${i}.params params/cofactor/${s}.params \
      -match:lig_name $i \
      -match:scaffold_active_site_residues pos/${s}.pos \
      -ex1 -ex2 -ex1aro -ex2aro \
      -output_format PDB \
      -consolidate_matches 1 \
      -ignore_unrecognized_res 1 \
      -match_grouper SameSequenceGrouper \
      -out:path:all out/match/ 
  done 
done
