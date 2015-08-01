from __future__ import print_function 
from sys import argv 
from core.db.amino_acid import THREE_to_one 

print( '>%s' % argv[1] ) 
with open( argv[1] ) as fn:
  for line in fn:
    if ' CA ' in line and line.startswith( 'ATOM' ):
      print( THREE_to_one( line.split()[3] ), end='' )
