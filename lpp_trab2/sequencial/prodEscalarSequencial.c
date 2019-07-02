//TRABALHO 2

#include <stdlib.h>
#include <stdio.h>

//openmp critical+temporario
//reduction
//temporario indexado pelo rank da thread temp[rank]
//comparação de tempo das 3	
//pensar novo

int main(int argc, char* argv[]){
    double sum;
    double a[256], b[256];
    int n=256, i;
    
    for(i=0; i<n; i++){
        a[i] = i * 0.5;
        b[i] = i * 2.0;
    }

    sum = 0;
    for(i = 1; i<n ; i++){
        sum = sum + a[i] * b[i];
    }

    printf("sum = %f\n", sum);
}
