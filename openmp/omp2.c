#include <stdio.h>
#include <omp.h>

void main(int argc, char** argv) {
    int my_rank;
    int num_processos; // número de processos
    float a=0.0, b=1.0; // intervalo a calcular
    int num_trap=1024*1024*1024; // número de trapezóides
    float h; // base do trapezóide
    float local_a, local_b; // intervalo local
    int local_n; // número de trapezóides local
    double integral; // integral no meu intervalo
    float total; // integral total
    int source; // remetente da integral
    int dest=0; // destino das integrais (nó 0)
    int tag=200; // tipo de mensagem (único)
    float calcula(float local_a, float local_b, int local_n, float h);
    int resto;
    
    h = (b-a) / num_trap;
    
    integral = 0;
    
    #pragma omp parallel for reduction(+:integral)
    for(int i=1; i < num_trap; i++) {
        integral += (i/(double)num_trap)*(i/(double)num_trap);
        //printf("Integral %f, thread %d\n", integral, omp_get_thread_num());
    }
    integral = integral * 1.0/num_trap;
    integral += 1.0/(2*num_trap);
    
    //integral *= h;
    total = integral;
    printf("Valor da integral: %f\n", total);
}


float calcula(float local_a, float local_b, int local_n, float h) {
    float integral;
    float x;
    float f(float x); // função a integrar
    int i;
    integral = 0;
    x = 0;
    
    return integral;
}

/*float calcula(float local_a, float local_b, int local_n, float h) {
    float integralCalc;
    float bEsq, bDir;
    float f(float x); // função a integrar
    bEsq = local_a;
    bDir = bEsq + h;
    int i = 0;
    
    //integral do exemplo estava errada
    //integral abaixo calculada utilizando ((b+B)*h/2) para todos os trapezios no intervalo
    #pragma omp for reduction(+:integralCalc)
    for( i=0; i<local_n; i++) {
        integralCalc += ((f(bEsq) + f(bDir)) * h)/2;   //((b+B)*h/2)
        bEsq += h;                                  //atualizando as novas bases
        bDir = bEsq + h;
    }
    
    
    return integralCalc;
}
*/


float f(float x) {
    float fx; // valor de retorno

    // esta é a função a integrar
    // exemplo: função quadrática
    fx = x * x;

    return fx;
}