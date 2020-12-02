rule download_reference:
    input:
        'data/macaque-url.txt'
    output:
        'data/ref/macaque-ref.fna.gz'
    shell:
        'wget -i {input} -O {output}'

rule gunzip_reference:
    input:
        'data/ref/macaque-ref.fna.gz'
    output:
        'data/ref/macaque-ref.fna'
    shell:
        'gunzip -c {input} > {output}'

rule download_reads:
    input:
        'data/{sex}-reads-url.txt'
    output:
        'data/reads/macaque-{sex}.srr'
    shell:
        'wget -i {input} -O {output}'

rule split_reads:
	input:
	    'data/reads/macaque-{sex}.srr'
	output:
	    'data/reads/macaque-{sex}_1.fastq'
            'data/reads/macaque-{sex}_2.fastq'
	shell:
	    'fastq-dump --split-spot {input}'

rule index_reference:
    input:
        'data/ref/macaque-ref.fna'
    output:
        directory('data/bwa-idx/')
    shell:
        'bwa index -p data/bwa-idx/macaque-ref {input}'

rule bwa_map:
    input:
        'data/bwa-idx/',
        fq1='data/reads/macaque-{sex}_1.fastq',
        fq2='data/reads/macaque-{seq}_2.fastq'
    output:
        'data/mapped/{sex}-mapped.sam'
    shell:
        'bwa mem -p -t 10 data/bwa-idx/macaque-ref {input.fq1} {input.fq2} > {output}'

rule convert_sam:
    input:
        'data/mapped/{sex}-mapped.sam'
    output:
        'data/mapped/{sex}-mapped.bam'
    shell:
        'samtools view -b {input} -o {output} && rm {input}'

rule bam_to_fasta:
    input:
        'data/mapped/{sex}-mapped.bam'
    output:
        'data/mapped/{sex}-mapped.fna'
    shell:
        'samtools fasta {input} > {output}'

