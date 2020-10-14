rule download-reference:
    input:
        'data/macaque-url.txt'
    output:
        'data/macaque-ref.fna.gz'
    shell:
        'wget -i {input} -O {output}'

rule gunzip-reference:
    input:
        'data/macaque-ref.fna.gz'
    output:
        'data/macaque-ref.fna'
    shell:
        'gunzip {input}'

rule download-reads:
    input:
        'data/{sex}-reads-url.txt'
    output:
        'data/reads/macaque-{sex}.fastq'
    shell:
        'wget -i {input} -O {output}'