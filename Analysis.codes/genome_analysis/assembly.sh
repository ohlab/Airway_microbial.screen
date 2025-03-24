#run prinseq
	perl /prinseq-lite.pl -fastq ${R1} -fastq2 ${R2} -phred64 -derep 1 -out_good ${prinseqPATH}/prinseq

#run trimmomatic 
	java -jar trimmomatic-0.39.jar PE -threads 4 ${prinseqPATH}/prinseq_1.fastq ${prinseqPATH}/prinseq_2.fastq ${trimPATH}/1P.fastq ${trimPATH}/1U.fastq ${trimPATH}/2P.fastq ${trimPATH}/2U.fastq ILLUMINACLIP:/projects/oh-lab/reffiles/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

#combine
	cat ${trimPATH}/1U.fastq ${trimPATH}/2U.fastq > ${trimPATH}/unpaired.fastq

#run spades
	SPAdes-3.7.1-Linux/bin/spades.py -t 8 -m 100 -1 ${trimPATH}/1P.fastq -2 ${trimPATH}/2P.fastq -s ${trimPATH}/unpaired.fastq -o ${spadesPATH}/assembled

#run quast
quast.py -t 15 ${spadesPATH}/assembled.fasta -o ${quastPATH}

#run Prokka
prokka ${spadesPATH}/assembled_contigs.fasta --kingdom Bacteria --compliant --outdir ${ProkkaPATH}/assembled --prefix assembled --cpus 5