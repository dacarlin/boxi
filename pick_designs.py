import pandas 

# read in scorefiles 
from glob import glob 

dfs = [ pandas.read_csv( i, sep=r'\s+' ) for i in glob( 'enzdes_out/*sc' ) ]
all = pandas.concat( dfs )

print len( all ) 
print all.columns

cut = all[ ( all.SR_1_pstat_pm > 0.5 ) & ( all.SR_2_pstat_pm > 0.5 ) & ( all.all_cst < 5 ) ]

from subprocess import call 

pdbs = [ 'enzdes_out/%s.pdb' % i for i in cut.description if 'BO' in i ] 
call( [ 'tar', '-cvf', 'cut_bo.tar' ] + pdbs ) 
print pdbs 
