import glob 
import json
import re
from core.db.amino_acid import THREE_to_one, ecoli_codon, aa, rc, one_to_THREE 

orders = [] # final output will be a list of dicts 
designs = glob.glob( 'designs/*des*pdb' ) # watch out! remove 'renum' 

for design in designs:
  scaffold = design.split( '/' )[-1][0:4] 

  with open( design ) as des_pdb, open( '../pdb/%s.pdb' % scaffold ) as wt_pdb: 
    wt = [ l.split()[3] for l in wt_pdb if 'CA' in l and l.startswith('ATOM') ] 
    d =  [ l.split()[3] for l in des_pdb if 'CA' in l and l.startswith('ATOM') ] 
    diff = zip( wt, d ) 
    m = [ ( j[0], i, j[1] ) for i, j in enumerate( diff ) if j[0] != j[1] ]

  with open( 'nucleotide/%s.fasta' % scaffold ) as fn:
    cds = ''.join( [ line.strip() for line in fn ] )

  codons = [ cds[ i:i+3 ] for i in range(0, len(cds), 3) ] 
  l = []

  for switch in m:
    old, i, new = switch 
    new1, old1 = ( THREE_to_one( new ), THREE_to_one( old ) ) 
    ori = one_to_THREE( aa[ codons[i] ] ) 
    if old == ori:
      codons[i] = ecoli_codon[ new1 ].upper()
      l += [i] 
    else:
      print 'error: mismatch when trying', old, i, new

  if l:
    e = rc( ''.join( codons[ min(l)-5:max(l)+6 ] ) )                                                      
    e = re.sub(r'([atcg]{15})[atcg]{0,}([atcg]{15})', r'\1,\2', e)                               

  handle = '+'.join( [ '%s%s%s' % ( THREE_to_one( s[0] ), s[1], THREE_to_one( s[2] ) ) for s in m ] ) 
  orders += [ { 'name': handle, 'oligos': [ { 'sequence': ee for ee in e.split( ',' ) } ] } ]

# transcriptic output format 
print json.dumps( 
  { 
    "parameters": { "ssDNA": "ssDNA/0", "mutants": orders , }, 
    "refs": { 
      "ssDNA": { 
        "aliquots": { "0": { "volume": "50:microliter" } }, 
        "id": '<ssDNA to use>', 
        "store": "cold_20", 
        "type": "micro-1.5" 
      } 
    } 
  }, indent=2 )


