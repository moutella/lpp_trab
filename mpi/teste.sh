#!/bin/bash

# 1024

mpicc mpi.c -o 1024traps.out
for i in {1..100}
do
	{ time mpirun -np 2 --hostfile hostfile  1024traps.out ; } 2>>mpi1024.txt
	#nota seria uma boa remover depois os prints para nao dar atraso de I/O

done




# 1024x1024x1024
mpicc mpi2.c -o muitostraps.out
for i in {1..100}
do
	{ time mpirun -np 2 --hostfile hostfile  muitostraps.out ; } 2>>mpimuitos.txt
	#nota seria uma boa remover depois os prints para nao dar atraso de I/O

done

