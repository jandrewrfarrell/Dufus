vcf=$1
contigs=$2
bam=$3
ref=$4

boom="*"
while IFS= read -r line; do 
	echo -E "$line"
	line2=$( awk '{print $1 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $10 "\t" $11}' <<< $line)
	echo -E $line2
	bamLine=($line2)
	echo -E "${bamLine[0]}"> ${bamLine[0]}.temp
	echo -E "${bamLine[1]}">> ${bamLine[0]}.temp
	echo -E "${bamLine[2]}">> ${bamLine[0]}.temp
	echo -E "${bamLine[3]}">> ${bamLine[0]}.temp
	echo -E "${bamLine[4]}">> ${bamLine[0]}.temp
        echo -E "${bamLine[5]}">> ${bamLine[0]}.temp
        echo -E "${bamLine[6]}">> ${bamLine[0]}.temp
	
	#####get reference sequence#######
	chr="${bamLine[1]}"
	start="${bamLine[2]}"
	string_length=${#bamLine[5]}
	end=$(echo "$start+$string_length"|bc)	
	bedtools getfasta -fi ~/references/grch38.fasta -bed <(echo -e "$chr\t$(echo "$start-1"|bc)\t$(echo "$end-1"|bc)")>>${bamLine[0]}.temp	

	#####get variant calls for this contig####
	grep ${bamLine[0]} $vcf >> ${bamLine[0]}.temp 
done < <(samtools view dJ_W9.bam.generator.V2.overlap.hashcount.fastq.bam)
