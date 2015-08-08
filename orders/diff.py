# outputs difference (in terms of mutations) between two protein sequences
# in the form <sequence a> <sequence b> 

import sys
for line in sys.stdin:
  if len( line ) > 400:
    sseq, qseq, qstart, qend = line.split() 
    print qstart, qend , 
    print '+'.join([ '%s%s%s' % (j[0].lower(), i, j[1].lower()) for i, j in enumerate(zip(sseq, qseq)) if j[1] != j[0] ]) 
      


