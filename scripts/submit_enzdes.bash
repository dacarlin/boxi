#! /bin/bash 

#$ -S /bin/bash
#$ -e /home/carlin/boxi/logs
#$ -o /home/carlin/boxi/logs 
#$ -N enzdes 

cd /home/carlin/boxi 
module load python
python scripts/decider.py  

