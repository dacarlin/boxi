#echo Prepping $( ls -1 designs/*des*pdb | wc -l ) designs 
for i in designs/*des*.pdb; do 
  python pdb_to_fasta.py $i > ${i/.pdb/.fasta}
  #nblastt -subject nucleotide/2v6g.fasta -query ${i/.pdb/.fasta} -outfmt "6 sseq qseq" | python diff.py 
  blastx -query nucleotide/2v6g.fasta -subject ${i/.pdb/.fasta} -outfmt "6 qseq sseq qstart qend" |\
  python diff.py 
done | python makeoligo.py nucleotide/2v6g.fasta | sort | uniq | python transcriptic_format.py
