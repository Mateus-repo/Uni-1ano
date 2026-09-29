#include <string.h>
#include <stdio.h>
#include <conio.h>
#include <stdlib.h>

void menu(void);
void obterNum(int *num);
void correrCiclo(char opcao, int *num, int *total);

int main(void)
{
    int num;
    int total = 0;
    char opcao;
    do
    {
        menu();
        printf("    Opcao -> ");
        scanf(" %c", &opcao);
        fflush(stdin);
        correrCiclo(opcao, &num, &total);
        if (opcao != 'S' && opcao != 's')
        {
            printf("A soma dos numeros de 1 a %d e igual a %d\n", num, total);
            printf("Prima qualquer tecla para continuar...\n");
            getch();
        }
    }while (opcao != 'S' && opcao != 's');
}

void menu(void)
{
    system("cls");
    printf("Menu de opcoes:\n");
    printf("W - Ciclo while\n");
    printf("D - Ciclo do-while\n");
    printf("F - Ciclo for\n");
    printf("S - Sair do programa\n");
}

void obterNum(int *num)
{
    do
    {
        printf("Escreva um numero inteiro positivo - ");
        scanf("%d", num);
        fflush(stdin);
        if (*num < 0)
        {
            printf("\nNumero invalido. Tente outro numero.\n\n");
            printf("---------------------------------\n\n");
        }
    } while (*num < 0);
}

void correrCiclo(char opcao, int *num, int *total)
{
    int i = 1;
    *total = 0;
    if(opcao != 'S' && opcao != 's')
        obterNum(num);
    switch (opcao)
    {
        case 'W':
        case 'w':
            while (i <= *num)
            {
                *total += i;
                i++;
            }
            break;
        case 'D':
        case 'd':
            do
            {
                *total += i;
                i++;
            } while (i <= *num);
            break;
        case 'F':
        case 'f':
            for (i = 1; i <= *num; i++)
            {
                *total += i;
            }
            break;
        case 'S':
        case 's':
            printf("A sair do programa...\n");
            break;
        default:
            printf("Opcao invalida. Tente novamente.\n");
    }
}