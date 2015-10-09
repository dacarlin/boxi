from glob import glob 

inputs = [ i.split( '/' )[-1] for i in glob( 'out/match/*pdb' ) 

