#!/bin/bash

# 1024

echo "MPI 4 Processos 1024 trapézios"
mpicc mpi.c -o 1024traps.out
time mpirun -np 4 --hostfile hostfile  1024traps.out

# 1024x1024x1024
echo ""
echo "MPI 4 Processos 1024^3 trapézios"
mpicc mpi2.c -o muitostraps.out
time mpirun -np 4 --hostfile hostfile  muitostraps.out

