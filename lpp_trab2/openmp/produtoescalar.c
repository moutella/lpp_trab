#include <stdlib.h>
#include <stdio.h>

// trabalho final parte 1...?  paraleelizar e IMPEDIR CONDIÇÃO DE CORRIDA DE 3 FORMAS DIFERENTES
int main(int argc, char* argv[]){
	double sum;
	double a[256], b[256];
	int n= 256,i;
	
	for(i =0; i<n; i++){
		a[i] = i*0.5;
		b[i] = i*2.0;
	}
	sum = 0;


	// condição de corrida aqui
	// quem fizer com critical DENTRO DO LOOP vai perder ponto!: temporaria e critical fora do loop
		// com tempo e fora do loop
		// reduce
		// temporario indexado pelo rank da thread temp[rank]?

	for(i = 0; i<n;i++){
		sum = sum + a[i]*b[i];
	}

	printf("sum = %f\n",sum);

}