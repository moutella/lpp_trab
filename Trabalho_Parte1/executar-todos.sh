#!/bin/bash

echo "MPI 4 Processos 1024 trapézios"
mpicc mpi/mpi.c -o mpi/1024traps.out
time mpirun -np 4 --hostfile hostfile mpi/1024traps.out

# 1024x1024x1024
echo ""
echo "MPI 4 Processos 1024^3 trapézios"
mpicc mpi/mpi2.c -o mpi/muitostraps.out
time mpirun -np 4 --hostfile hostfile  mpi/muitostraps.out


gcc openmp/omp.c -o openmp/1024traps.out -fopenmp
echo "Execução com 4 threads openMP 1024 trapézios"
export OMP_NUM_THREADS=4
time openmp/1024traps.out

#1024^3
gcc openmp/omp2.c -o openmp/muitostraps.out -fopenmp
echo ""
echo "Execução com 4 threads openMP 1024^3 trapézios"
export OMP_NUM_THREADS=4
time openmp/muitostraps.out


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
