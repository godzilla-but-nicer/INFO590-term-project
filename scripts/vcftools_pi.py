import sys
import os

# command line args
vcf_file = sys.argv[1]
window_size = int(sys.argv[2])
step_size = int(sys.argv[3])

# going to simplity the names a bit here
simple_sample = vcf_file.split('/')[-1].split('.')[0].split('_')[1]
path = 'vcftools/'

os.system('vcftools --vcf ' + vcf_file + '--window-pi ' + window_size + '--window-pi-step ' + step_size + '--out ' + path + simple_sample)
