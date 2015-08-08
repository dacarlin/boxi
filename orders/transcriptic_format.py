import sys 
import uuid

print 'mutant_label,sequencing_primer,oligo_label,sequence,scale,purification'

for line in sys.stdin:
  mutant = line.split( ',' )[0]
  oligos = line.strip().split( ',' )[1:]

  for index, oligo in enumerate( oligos ):
    print '%s,T7pro,%s,%s,25nm,standard' % ( mutant, uuid.uuid4(), oligo ) 
