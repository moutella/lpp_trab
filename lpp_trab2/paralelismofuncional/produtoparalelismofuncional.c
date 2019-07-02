#include <stdlib.h>
#include <stdio.h>
#include <omp.h>

// trabalho final parte 1...?  paraleelizar e IMPEDIR CONDIÇÃO DE CORRIDA DE 3 FORMAS DIFERENTES
int main(int argc, char* argv[]){
	double sum;
	double a[256], b[256];
	int n= 256,i;
	
	for(i =0; i<n; i++){
		a[i] = (i)*0.5;
		b[i] = (i)*2.0;
	}
	sum = 0;

	double temp = 0;
	double temp2 = 1;
	// condição de corrida aqui
	// quem fizer com critical DENTRO DO LOOP vai perder ponto!: temporaria e critical fora do loop
		// com tempo e fora do loop
		// reduce
		// temporario indexado pelo rank da thread temp[rank]?
	#pragma omp sections 
	{

		// alteração PARELELISMO FUNCIONAL (executar soma e produto em paralelo!)
		// acaba com condição de corrida cada uma pega uma variavel diferente!
		// nao é paralelismo de dados

		#pragma omp section
		for(i = 0; i<n;i++){
			temp = temp + a[i]*b[i];
		}
		
		#pragma omp section
		for(i = 0; i<n;i++){
			temp2 = temp2 * a[i]*b[i];
		}

	}
	

	printf("total %f , %f \n",temp,temp2);

}