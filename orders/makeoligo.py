#from db.amino_acid import aa, cod, one, rc

def rc(seq):
  c = [{ 'a':'t', 't':'a', 'g':'c', 'c':'g', 'A': 'T', 'T': 'A', 'G': 'C', 'C': 'G' }[i] for i in str(seq)] 
  return ''.join(c)[::-1]

aa = { 'ata':'i', 'atc':'i', 'att':'i', 'atg':'m', 'aca':'t', 'acc':'t', 'acg':'t', 'act':'t', 'aac':'n', 'aat':'n', 'aaa':'k', 'aag':'k', 'agc':'s', 'agt':'s', 'aga':'r', 'agg':'r', 'cta':'l', 'ctc':'l', 'ctg':'l', 'ctt':'l', 'cca':'p', 'ccc':'p', 'ccg':'p', 'cct':'p', 'cac':'h', 'cat':'h', 'caa':'q', 'cag':'q', 'cga':'r', 'cgc':'r', 'cgg':'r', 'cgt':'r', 'gta':'v', 'gtc':'v', 'gtg':'v', 'gtt':'v', 'gca':'a', 'gcc':'a', 'gcg':'a', 'gct':'a', 'gac':'d', 'gat':'d', 'gaa':'e', 'gag':'e', 'gga':'g', 'ggc':'g', 'ggg':'g', 'ggt':'g', 'tca':'s', 'tcc':'s', 'tcg':'s', 'tct':'s', 'ttc':'f', 'ttt':'f', 'tta':'l', 'ttg':'l', 'tac':'y', 'tat':'y', 'taa':'_', 'tag':'_', 'tgc':'c', 'tgt':'c', 'tga':'_', 'tgg':'w'} 

cod = { 'g':'ggc', 'a':'gcg', 'v':'gtg', 'f':'ttt', 'e':'gaa', 'd':'gat', 'n':'aac', 'h':'cat', 'p':'ccg', 'q':'cag', 'w':'tgg', 'y':'tat', 'i':'att', 'm':'atg', 'c':'tgc', 'k':'aaa', 'l':'ctg', 'r':'cgt', 't':'acc', 's':'agc'}

from sys import argv, stdin 
import re
import screed 

for line in stdin:
  qstart, qend, muts = line.split() 
#    print line.split() 

  for record in screed.open( argv[1] ):
    trimmed = record.sequence[ int( qstart ) - 1 : int( qend ) ] 

  codons = [ trimmed[i:i+3] for i in range(0, len( trimmed ), 3) ]
  l = []
  switches = re.split(r'\+', muts)
  for switch in switches:
    old = switch[0]
    new = switch[-1]
    i = int( switch[1:-1] ) 
    ori = aa[ codons[ i ] ] 
    if old.lower() == ori:
      codons[ i-1] = cod[new].upper()
      l += [i]
    else :
      e = 'error: you say ' + old + ' but seq has ' + ''.join( [   aa[ codons[i] ] for i in range(i-5,i+5) ] ) 
      break
  if l:
    e = rc( ''.join( codons[ min( l ) - 6 : max( l ) + 4 ] )  )
    e = re.sub(r'([atcg]{15})[atcg]{0,}([atcg]{15})', r'\1,\2', e)
  print '+'.join(switches) + ',' + e 

