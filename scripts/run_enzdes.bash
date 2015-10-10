#$ -S /bin/bash
#$ -e /home/carlin/boxi/logs
#$ -o /home/carlin/boxi/logs
#$ -N design 

#example UM_100_H101W129_1_1lua_SBO_HW_HW_1.pdb

export ROSETTA3_DB=/share/tmp-data-1/siegellab/Rosetta/main/database/
export PATH=/share/tmp-data-1/siegellab/Rosetta/main/source/bin/:$PATH
cd /home/carlin/boxi

S=$( sed "${SGE_TASK_ID}q;d" list/design_in.txt ) 
LIG=$( echo $S | cut -d_ -f6 ) 
PDB=$( echo $S | cut -d_ -f5 ) 
CST=$( echo $S | cut -d_ -f6,7,8 ) 

echo 'REMARK 666 MATCH TEMPLATE X' $LIG '0 MATCH MOTIF B NAX 1 3 1' > out/enzdes/$S 
cat out/secondary/$S >> out/enzdes/$S 

rosetta_scripts.linuxgccrelease @ scripts/enzdes.flags -s out/enzdes/$S -extra_res_fa params/cofactor/$PDB.params params/ligand/$LIG.params -enzdes:cstfile cst/enzdes/${CST}_NAD.cst 

