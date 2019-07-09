#!/bin/bash

echo "Produto Esclar: MPI 4 Processos"
mpicc mpi/mpi.c -o mpi/prodescalMPI.out

for i in {1..100}
do
	{ time mpirun -np 4 --hostfile hostfile mpi/prodescalMPI.out ; } 2>>resultados/mpi.txt
done

echo "Produto Escalar: openMP 4 threads (Critical)"
gcc openmp/produtoescalarcritical.c -o openmp/critical.out -fopenmp
export OMP_NUM_THREADS=4

for i in {1..100}
do
	{ time ./openmp/critical.out ; } 2>>resultados/openmpcritical.txt 
done

echo "Produto Escalar: openMP 4 threads (Reduce)"
gcc openmp/produtoescalarreduce.c -o openmp/reduce.out -fopenmp
export OMP_NUM_THREADS=4

for i in {1..100}
do
	{ time ./openmp/reduce.out ; } 2>>resultados/openmpreduce.txt 
done

echo "Produto Escalar: openMP 4 threads (Forma alternativa)"
gcc openmp/produtoescalar.c -o openmp/extra.out -fopenmp
export OMP_NUM_THREADS=4

for i in {1..100}
do
	{ time ./openmp/extra.out ; } 2>>resultados/extra.txt 
done

#### escolher um deles para fazer schedule dynamic 

echo "Sections (Paralelismo Funcional): openMP 4 threads"
gcc paralelismofuncional/sections.c -o paralelismofuncional/sections.out -fopenmp
export OMP_NUM_THREADS=4

for i in {1..100}
do
	{ time ./paralelismofuncional/sections.out ; } 2>>resultados/sections.txt 
done


mpicc hibrido.c -o hibrido.out
echo "Execução híbrida 2 processos e 2 threads"
export OMP_NUM_THREADS=2

for i in {1..100}
do
	{ time mpirun -np 2 --hostfile hostfile hibrido.out ; } 2>>resultados/hibrido.txt
done


echo "Produto Escalar: openMP 4 threads (Critical)(Static)"
gcc openmp/produtoescalarcriticalstatic.c -o openmp/produtoescalarcriticalstatic.out -fopenmp
export OMP_NUM_THREADS=4

for i in {1..100}
do
	{ time ./openmp/produtoescalarcriticalstatic.out ; } 2>>resultados/static.txt 
done


echo "Produto Escalar: openMP 4 threads (Critical)(Dynamic)"
gcc openmp/produtoescalarcriticaldyna.c -o openmp/produtoescalarcriticaldynamic.out -fopenmp
export OMP_NUM_THREADS=4

for i in {1..100}
do
	{ time ./openmp/produtoescalarcriticaldynamic.out ; } 2>>resultados/dynamic.txt 
done