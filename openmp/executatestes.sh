#!/bin/bash

#1024

gcc omp.c -o 1024traps.out -fopenmp
export OMP_NUM_THREADS=4
for i in {1..100}
do
	{ ./1024traps.out ; } 2>>openmp1024.txt

done



# 1024x1024x1024
gcc omp2.c -o muitostraps.out -fopenmp
export OMP_NUM_THREADS=4
for i in {1..100}
do
	{ ./muitostraps.out ; } 2>>openmp1024x1024x1024.txt

done

