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
        'data/reads/macaque-{sex}.fastq'
    shell:
        'wget -i {input} -O {output}'

rule index_reference:
    input:
        'data/ref/macaque-ref.fna'
    output:
        'data/bwa-idx/macaque-ref.amb',
        'data/bwa-idx/macaque-ref.ann',
        'data/bwa-idx/macaque-ref.bwt',
        'data/bwa-idx/macaque-ref.pac',
        'data/bwa-idx/macaque-ref.sa'
    shell:
        'bwa index -p data/bwa-idx/macaque-ref {input}'

rule bwa_map:
    input:
        'data/bwa-idx/macaque-ref',
        'data/reads/macaque-{sex}.fastq'
    output:
        'data/mapped/{sex}-mapped.sam'
    threads: 24
    shell:
        'bwa-mem2 mem -t {threads} {input} > {output}'

rule convert_sam:
    input:
        'data/mapped/{sex}-mapped.sam'
    output:
        'data/mapped/{sex}-mapped.bam'
    shell:
        'samtools view -Sb {input} > {output} && rm {input}'
