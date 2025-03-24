#KEGG enrichment usearch
	usearch -ublast ${inPATH}/sample.ffn -db orthology_uniref90_2_2157_4751.20190806012959.udb -blast6out ${enrichPATH}/blast.txt -evalue 1e-9 -threads 15 -maxhits 1

#KEGG abundance
	perl FMAP_quantification.pl -i 80 ${enrichPATH}/blast.txt > ${abundancePATH}/abundance.txt

# FMAP_table.pl: generate gene abundance table
perl FMAP_table.pl $(cat table.list.txt) > ${fmapPATH}/merged_RPKM_table.txt

# FMAP_comparison.pl: compare sample groups and identify differentially-abundant genes
perl FMAP_comparison.pl ${fmapPATH}/merged_RPKM_table.txt ${fmapPATH}/group1.txt ${fmapPATH}/group2.txt > ${fmapPATH}/comparison_table.txt

# FMAP_operon.pl: mapping differentially-abundant genes to operons
perl FMAP_operon.pl ${fmapPATH}/comparison_table.txt > ${fmapPATH}/operon_table.txt

# FMAP_pathway.pl: mapping differentially-abundant genes to KEGG pathways
perl FMAP_pathway.pl ${fmapPATH}/comparison_table.txt > ${fmapPATH}/KEGG_pathway_table.txt

# FMAP_module.pl: mapping differentially-abundant genes to KEGG modules
perl FMAP_module.pl ${fmapPATH}/comparison_table.txt > ${fmapPATH}/KEGG_module_table.txt
