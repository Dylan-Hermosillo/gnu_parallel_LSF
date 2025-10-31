#! /bin/bash

#-j n            Run n jobs in parallel

CPUS=6
PARALLEL=/rs1/shares/brc/admin/tools/parallel-20250922/bin/parallel
cat all_commands.txt | $PARALLEL -j $CPUS -a - 
