#include <stdio.h>
#include <conio.h>

int main(void)
{
    int numero = 0;
    printf("Escreva um numero inteiro\n");
    scanf("%d", &numero);
    if(numero!=0)
    {
        if(numero>0)
        {
            printf("O numero e positivo");
        }
        else
        {
            printf("O numero e negativo");
        }
        if(numero%2==0)
        {
            printf(" e par");
        }
        else
        {
            printf(" e impar");
        }
        printf("\n");
    }
    else
    {
        printf("O numero e nulo\n");
    }
    return 0;
}
