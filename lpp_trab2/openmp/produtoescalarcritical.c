#include <stdlib.h>
#include <stdio.h>
#include <omp.h>

// trabalho final parte 1...?  paraleelizar e IMPEDIR CONDIÇÃO DE CORRIDA DE 3 FORMAS DIFERENTES
int main(int argc, char* argv[]){
	double sum;
	double valor;
	double a[256], b[256];
	int n= 256,i;
	
	for(i =0; i<n; i++){
		a[i] = i*0.5;
		b[i] = i*2.0;
	}
	sum = 0;
	// condição de corrida aqui
	// quem fizer com critical DENTRO DO LOOP vai perder ponto!: temporaria e critical fora do loop
		// com temp e fora do loop
		// reduce
		// temporario indexado pelo rank da thread temp[rank]?

	// ISSO AQUI TA MUITO ERRADO (ele ta percorrendo o vetor INTEIRO 4 vezes (o numero de threads vezes))
	#pragma omp parallel shared(a,b,sum) private(valor,i)
	{
		double temp = 0;
		#pragma omp for
		for(i = 0; i<n;i++){
			valor = a[i]*b[i];
			temp = temp + valor;
			//printf("Thread%d: %f (%d) \n",omp_get_thread_num(),temp,i);
		}
		#pragma omp critical
		sum = sum + temp;

	}
	printf("sum = %f\n",sum);

}