# use: bash merge.bash <transcriptic mapping CSV>

dos2unix $1 # fix any stupid DOS input files 
mkdir out 

for i in $( cut -d, -f3 $1 | tr -d + ); do
  ASEQ=fwd_reads/$i*seq
  BSEQ=rev_reads/$i*seq
  merger -asequence $ASEQ -bsequence $BSEQ -sreverse2 -outfile out/$i.merger -outseq out/$i.fasta
done 

for i in out/*fasta; do
  blastn -subject 1oaa.fasta -query $i -out ${i/fasta/blast}  
  blastn -subject 1oaa.fasta -query $i -outfmt "6 sseq qseq" -out ${i/fasta/aligned} 
  tblastn -subject $i -query 1oaa.pep -outfmt "6 qseq sseq" -out ${i/fasta/diff} 
done 
