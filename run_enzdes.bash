#!/bin/bash
#$ -cwd 
#$ -S /bin/bash
#$ -e logs
#$ -o logs
#$ -N enzdes 


#example UM_100_H101W129_1_1lua_SBO_HW_HW_1.pdb

export ROSETTA3_DB=/share/tmp-data-1/siegellab/Rosetta/main/database/
export PATH=/share/tmp-data-1/siegellab/Rosetta/main/source/bin/:$PATH

i=$( awk 'NR=="'${SGE_TASK_ID}'" { print $0 }' enzdes_list.txt )

IFS='_' read -a array <<< "$i" 

SCAFFOLD=${array[4]} 
LIGAND=${array[5]}
DYAD=$( printf "%s_%s" ${array[6]} ${array[7]} )

echo 'REMARK 666 MATCH TEMPLATE X' $LIGAND '   0 MATCH MOTIF B NAX    1  3  1 ' > enzdes_in/$i.nad.pdb
cat match_out/$i >> enzdes_in/$i.nad.pdb

rosetta_scripts.linuxgccrelease @ enzdes.flags -s enzdes_in/$i.nad.pdb -extra_res_fa input_params/${SCAFFOLD}.params -extra_res_fa params/${LIGAND}.params -out:path:all enzdes_out_big -enzdes:cstfile cst/enzdes/NAD_${LIGAND}_${DYAD}.cst 

