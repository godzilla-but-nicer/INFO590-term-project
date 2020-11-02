rule download-reference:
    input:
        'data/macaque-url.txt'
    output:
        'data/ref/macaque-ref.fna.gz'
    shell:
        'wget -i {input} -O {output}'

rule gunzip-reference:
    input:
        'data/ref/macaque-ref.fna.gz'
    output:
        'data/ref/macaque-ref.fna'
    shell:
        'gunzip -c {input} > {output}'

rule download-reads:
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
        'data/bwa-index/macaque-ref.amb',
        'data/bwa-index/macaque-ref.ann',
        'data/bwa-index/macaque-ref.bwt',
        'data/bwa-index/macaque-ref.pac',
        'data/bwa-index/macaque-ref.sa'
    shell:
        'bwa index -p data/bwa-idx/macaque-ref {input}'

rule map_reads:
    input:
        ref = 'data/macaque-ref.fna',
        reads = 'data/reads/macaque-{sex}.fastq'
    output:
        'something, figure out later'
    shell:
        'ls -la'
