funannotate sort -i ${spadesPATH}/assembled_contigs.fasta -o ${funPATH}/clean.fasta 

funannotate mask -i ${funPATH}/clean.fasta  -o ${funPATH}/softmasked.fasta -m repeatmodeler -m repeatmasker -cpus 15

funannotate predict -i ${funPATH}/softmasked.fasta -o ${funPATH}/predict -s "Candida glabrata" --cpus 15
