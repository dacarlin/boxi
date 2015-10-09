from glob import glob 

inputs = [ i.split( '/' )[-1].split( '_' ) for i in glob( 'out/match/*pdb' ) ] 

for input in inputs: 
  s = ''.join( input ) 
  scaffold = input[ 4 ] 
  ligand = input[ 5 ]
  motif = input[ 6 ] + '_' + input[ 7 ] 

  print 'rosettascripts.linuxgccrelease', 
    '-s {} '.format( input ) 
