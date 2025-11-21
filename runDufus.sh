vcf=$1
contigs=$2
bam=$3

while IFS= read -r line; do 
	echo "$line"
	bamLine=($line)
	echo "${bamLine[0]}"
done < <(samtools view dJ_W9.bam.generator.V2.overlap.hashcount.fastq.bam)
