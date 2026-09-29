#include <string.h>
#include <stdio.h>
#include <conio.h>
#include <stdlib.h>

int main(void)
{
    int num;
    int total = 0;
    do{
        printf("Escreva um numero inteiro positivo - ");
        scanf("%d", &num);
        fflush(stdin);
        if(num < 0){
            printf("\nNumero invalido. Tente outro numero.\n\n");
            printf("---------------------------------\n\n");
        }
    }while(num < 0);
    for (int i = 1; i <= num; i++)
    {
        total += i;
    }
    printf("A soma dos numeros de 1 a %d e igual a %d\n", num, total);
}