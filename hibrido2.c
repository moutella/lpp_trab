#include <stdio.h>
#include <mpi.h>
#include <omp.h>

void main(int argc, char** argv) {
    int my_rank;
    //omp_set_num_threads(2);
    int num_processos; // número de processos
    float a=0.0, b=1.0; // intervalo a calcular
    int num_trap=1024*1024*1024; // número de trapezóides
    float h; // base do trapezóide
    float local_a, local_b; // intervalo local
    int local_n; // número de trapezóides local
    double integral; // integral no meu intervalo
    double total; // integral total
    int source; // remetente da integral
    int dest=0; // destino das integrais (nó 0)
    int tag=200; // tipo de mensagem (único)
    int resto;
    

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
    MPI_Comm_size(MPI_COMM_WORLD, &num_processos);
    h = (b-a) / num_trap;
    int num_trap_rank = num_trap/num_processos;
    
    //printf("NUM PER RANK: %d\n", num_trap_rank);
    integral = 0;
    
    #pragma omp parallel for reduction(+:integral)
    for(int i=0 + num_trap_rank * my_rank; i < (1+ my_rank) * num_trap_rank; i++) {
        integral += (i/(double)num_trap)*(i/(double)num_trap);
        //printf("Integral %f, thread %d\n", integral, omp_get_thread_num());
    }
    
    integral = integral * 1.0/num_trap;
    if(my_rank==num_processos-1)
    integral += 1.0/(2*num_trap_rank*(1+my_rank));
    
    //printf("Integral: %f, rank %d\n", integral, my_rank);
    MPI_Reduce(&integral, &total, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
	
    if(my_rank == 0){
	//printf("Resultado: %f\n", total);
    } 
    MPI_Finalize();
}
