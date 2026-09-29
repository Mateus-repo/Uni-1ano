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

int main(void)
{
    valores v;
    obterValores(&v);

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