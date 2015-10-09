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

match.linuxgccrelease @ flags/match.flags @ flags/$s.flags @ flags/${i}_${j}.flags
mv UM* out/secondary/
