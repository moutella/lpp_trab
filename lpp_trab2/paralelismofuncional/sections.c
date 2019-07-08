#include <stdlib.h>
#include <stdio.h>
#include <omp.h>


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
	#pragma omp sections 
	{

		// alteração PARELELISMO FUNCIONAL (executar soma e produto em paralelo com uma segunda operação (a de multiplicacao))
		// nao é paralelismo de dados

		#pragma omp section
		for(i = 0; i<n;i++){
			temp = temp + a[i]*b[i];
		}
		
		#pragma omp section
		for(i = 0.5; i<n;i++){
			temp2 = temp2 * a[i]*b[i];
		}

	}
	

	//resultado esperado:   5559680.000000 ,  0 (ou inifinito se o i iniciar em (1))
	//printf("total %f , %f \n",temp,temp2);

}