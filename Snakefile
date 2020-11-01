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
        'gunzip {input} > {output}'

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
        'data/ref/idx-macaque-ref.fna'
    shell:
        'bwa index -p idx-macaque {output}'

rule map_reads:
    input:
        ref = 'data/macaque-ref.fna',
        reads = 'data/reads/macaque-{sex}.fastq'
    output:
        'something, figure out later'
    shell:
        'ls -la'
