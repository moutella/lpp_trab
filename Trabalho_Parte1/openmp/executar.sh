#!/bin/bash

#1024

gcc omp.c -o 1024traps.out -fopenmp
echo "Execução com 4 threads openMP 1024 trapézios"
export OMP_NUM_THREADS=4
time ./1024traps.out

#1024^3
gcc omp2.c -o muitostraps.out -fopenmp
echo ""
echo "Execução com 4 threads openMP 1024^3 trapézios"
export OMP_NUM_THREADS=4
time ./muitostraps.out
