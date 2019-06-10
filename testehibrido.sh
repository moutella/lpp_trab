#!/bin/bash

# 1024

mpicc hibrido.c -o H1024.out
export OMP_NUM_THREADS=2
for i in {1..100}
do
	{ time mpirun -np 2 --hostfile hostfile  H1024.out; } 2>>H1024.txt
	#nota seria uma boa remover depois os prints para nao dar atraso de I/O

done




# 1024x1024x1024
mpicc hibrido2.c -o muitos.out
export OMP_NUM_THREADS=2
for i in {1..100}
do
	{ time mpirun -np 2 --hostfile hostfile  muitos.out ; } 2>>muitos.txt
	#nota seria uma boa remover depois os prints para nao dar atraso de I/O

done

