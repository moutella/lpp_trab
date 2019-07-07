#include <stdlib.h>
#include <stdio.h>
#include <omp.h>


int main(int argc, char* argv[]){
	double sum;
	double a[256], b[256];
	int n= 256,i;
	
	for(i =0; i<n; i++){
		a[i] = i*0.5;
		b[i] = i*2.0;
	}
	sum = 0;
	
	int totalthreads = omp_get_max_threads();
	
	//para debug
	//printf("total threads: %d \n",totalthreads);
	
	double bancodasthreads[totalthreads]; 

	//versao indexada pelo rank
	#pragma omp parallel for 
	for(i = 0; i<n;i++){
		//para debug
		//printf("(%d): %d  \n",omp_get_thread_num(),i );
		bancodasthreads[omp_get_thread_num()] =  bancodasthreads[omp_get_thread_num()] +  (a[i] * b[i]);
	}
	// agora percorre o "banco" e devolve o resultado
	for(i = 0 ; i < totalthreads; i++ ){
		sum = sum+ bancodasthreads[i];
	}

	//removendo para agilizar o teste (se formos rodar varias vezes)
	//printf("sum = %f\n",sum);

}