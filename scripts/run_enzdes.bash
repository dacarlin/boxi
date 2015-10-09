#!/bin/bash
#$ -S /bin/bash
#$ -e /home/carlin/boxi/logs
#$ -o /home/carlin/boxi/logs
#$ -N enzdes 

#example UM_100_H101W129_1_1lua_SBO_HW_HW_1.pdb

export ROSETTA3_DB=/share/tmp-data-1/siegellab/Rosetta/main/database/
export PATH=/share/tmp-data-1/siegellab/Rosetta/main/source/bin/:$PATH
cd /home/carlin/boxi 

LINE="$( awk 'NR=="'${SGE_TASK_ID}'" { print $0 }' list/match_out.txt )"
IFS='_' read -a A <<< "$LINE" 

SCAFFOLD=${A[4]} 
LIGAND=${A[5]}
DYAD=$( printf "%s_%s" ${A[6]} ${A[7]} )

( echo 'REMARK 666 MATCH TEMPLATE X ' ${A[5]} ' 0 MATCH MOTIF B NAX 1 3 1' && cat $LINE ) > ${LINE/.pdb/_nad.pdb} 

#head ${LINE/.pdb/_nad.pdb} 

echo rosetta_scripts.linuxgccrelease @ scripts/enzdes.flags -s ${LINE/.pdb/_nad.pdb} -extra_res_fa params/cofactor/${SCAFFOLD}.params -extra_res_fa params/ligand/${LIGAND}.params -out:path:all out/enzdes/ -enzdes:cstfile cst/enzdes/${LIGAND}_${DYAD}_NAD.cst 

