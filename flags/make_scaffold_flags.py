with open( '../list/scaffold.txt' ) as fn:
  for line in fn:
    with open( '{}.flags'.format( line.strip() ), 'w' ) as fn2: 
      fn2.write( '-in:file:s pdb/{0}.pdb\n-extra_res_fa params/cofactor/{0}.params\n-match:scaffold_active_site_residues pos/{0}.pos'.format( line.strip() ) ) 
