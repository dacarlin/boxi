for i in 1 2 3 4 5 6 7 8; do 
  for j in a b c; do 
    merger -asequence alex${i}${j}f*.seq -bsequence alex${i}${j}r*.seq \
      -sreverse2 -outfile $i$j.merger -outseq $i$j.fasta 
  
  done
done 
