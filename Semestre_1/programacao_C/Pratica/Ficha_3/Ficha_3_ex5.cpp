#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
#include <math.h>

struct valores
{
    int m;
    int n;
};

void obterValores(valores *v);
int calcularSigma(int m, int n);

int main(void)
{
    valores v;
    obterValores(&v);
    int resultado = calcularSigma(v.m, v.n);
    printf("O resultado da soma sigma de %d a %d e igual a %d\n", v.m, v.n, resultado);
    return 0;
}

void obterValores(valores *v)
{
    do
    {
        printf("Escreva o valor de m - ");
        scanf("%d", &v->m);
        fflush(stdin);
        if (v->m < 0)
        {
            printf("\nValor invalido. Tente outro valor.\n\n");
            printf("---------------------------------\n\n");
        }
    } while (v->m < 0);

    do
    {
        printf("Escreva o valor de n - ");
        scanf("%d", &v->n);
        fflush(stdin);
        if (v->n < 0 || v->n < v->m)
        {
            printf("\nValor invalido ou menor que %d. Tente outro valor.\n\n", v->m);
            printf("---------------------------------\n\n");
        }
    } while (v->n < 0 || v->n < v->m);
}

int calcularSigma(int m, int n)
{
    int soma = 0;
    for (int i = m; i <= n; i++)
    {
        soma += ((double)(2*i) / (5 + pow(i, 2)));
    }
    return soma;
}