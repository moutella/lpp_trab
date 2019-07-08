#include <stdlib.h>
#include <stdio.h>
#include <mpi.h>
#include <omp.h>

//ex:
/* 10 posições do vetor /4 


	2 para cada processo faltando 2 para serem distribuidos...
	resto 2 ou seja o processo 0 e 1 vao ter +1 posição do vetor para pegar

	original:

	processo 0 :  0, 1
	processo 1 :  2, 3
	processo 2 :  4, 5
	processo 3 :  6, 7
	total :   		8

	faltam 2...

	balanceamento...

	poderia fazer assim... sabemos que o "FINAL" é 8 ou seja jogando o 8 e 9 para os processos restantes 
	ou ir "empurrando" o intervalo de todo mundo!

	"empurrando:"

	processo 0 : 2 + 1 ( 0, 1 ) + 1 =  (0,1,2)
	processo 1 : 2 + 1 (3,4,5)
	processo 2 : (6,7)
	processo 3 : (8,9)
	o resto tem que permanecer inalterado... 

	(parece a solução mais facil)
	"final"

	processo 0: (0,1,8)
	processo 1: (2,3, 9)
	processo 2: (4,5)
	processo 3: (6,7)
*/

int main(int argc, char* argv[]){

// inicializa os 2 vetores    
 	double sum;
 	int n =256, i;
	double a[n],b[n];
	for(i = 0; i<n; i++){
		a[i] = i*0.5;
		b[i] = i*2.0;
	}
	sum = 0;

	// inicialização do MPI
	int my_rank;
	int num_processos;

	int local_n;  // numero de pedaços do vetor para cada processo
	double total; // (resultado da soma quando fizer reduce para o processo mestre)
	int resto;  // resto caso seja um numero de processos incompativeis com n
	int dest=0; // destino das integrais (nó 0)
	int tag=200; // tipo de mensagem (único)
	MPI_Status status;
	MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
	MPI_Comm_size(MPI_COMM_WORLD, &num_processos);

	local_n = n / num_processos;
	//printf("LOCAL n: %d\n",local_n);
	resto = n%num_processos;
	//printf("RESTO: %d \n",resto);
	
	double aux = 0;


	if(my_rank < resto){
		// um pedaço do array a mais
		// total (n) -  local_n 
		// processo 0:  10 - 2 = 8
		//processo  1:  10 - (2+1) = 9
		int amais = n - (local_n)+my_rank;
		//printf("TEM RESTO(%d): %d \n",my_rank,amais);
		aux = aux + a[amais]*b[amais];
	}

	
//	#pragma omp parallel 
//	{

		#pragma omp parallel for reduction(+:aux)	
		for(i = my_rank*local_n; i < local_n*(my_rank+1); i++){
			//printf("processo(%d): %d \n",my_rank,i);
			aux = aux + a[i]*b[i];
		}
		//printf("processo(%d) TOTAL: %f \n",my_rank,aux);
		MPI_Reduce(&aux, &sum, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
	
//	}
	
	if(my_rank == 0){
		//printf("Resultado: %f \n",sum);
	}
	MPI_Finalize();

}