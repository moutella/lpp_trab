#!/bin/bash

# 1024

mpicc hibrido.c -o H1024.out
echo "Execução híbrida 1024 trapézios"
export OMP_NUM_THREADS=2
time mpirun -np 2 --hostfile hostfile  H1024.out




# 1024x1024x1024
mpicc hibrido2.c -o muitos.out
echo ""
echo "Execução híbrida 1024^3 trapézios"
export OMP_NUM_THREADS=2
time mpirun -np 2 --hostfile hostfile  muitos.out
