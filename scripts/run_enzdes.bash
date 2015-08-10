#!/bin/bash
#$ -cwd 
#$ -S /bin/bash
#$ -e logs
#$ -o logs
#$ -N enzdes 

#example UM_100_H101W129_1_1lua_SBO_HW_HW_1.pdb

export ROSETTA3_DB=/share/tmp-data-1/siegellab/Rosetta/main/database/
export PATH=/share/tmp-data-1/siegellab/Rosetta/main/source/bin/:$PATH

IFS='_' read -a A <<< "$( awk 'NR=="'${SGE_TASK_ID}'" { print $0 }' list/match_out.txt )"

SCAFFOLD=${A[4]} 
LIGAND=${A[5]}
DYAD=$( printf "%s_%s" ${A[6]} ${A[7]} )

( echo 'REMARK 666 MATCH TEMPLATE X' ${A[5]} '   0 MATCH MOTIF B NAX    1  3  1 ' && cat $i 

echo rosetta_scripts.linuxgccrelease @ enzdes.flags -s enzdes_in/$i.nad.pdb -extra_res_fa input_params/${SCAFFOLD}.params -extra_res_fa params/${LIGAND}.params -out:path:all enzdes_out -enzdes:cstfile cst/enzdes/${LIGAND}_${DYAD}_NAD.cst 

