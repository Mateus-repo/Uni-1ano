#include <string.h>
#include <stdio.h>
#include <conio.h>
#include <stdlib.h>

void mostrarMenu();
int leNumeroPositivoMaiorQue1();
int somarIntervalo(int num);

int main(void)
{
    int num;
    int total = 0;
    mostrarMenu();
    num = leNumeroPositivoMaiorQue1();
    total = somarIntervalo(num);
    printf("A soma dos numeros de 1 a %d e igual a %d\n", num, total);
}

void mostrarMenu()
{
    printf("Calculo da soma dos numeros de 1 a n\n");
    printf("Escreva um numero inteiro positivo maior que 1 - ");
}

int leNumeroPositivoMaiorQue1()
{
    int num;
    do
    {
        scanf("%d", &num);
        fflush(stdin);
        if (num <= 1)
        {
            printf("Por favor, insira um numero inteiro positivo maior que 1: ");
        }
    } while (num <= 1);
    return num;
}

int somarIntervalo(int num)
{
    int total = 0;
    for (int i = 1; i <= num; i++)
    {
        total += i;
    }
    return total;
}