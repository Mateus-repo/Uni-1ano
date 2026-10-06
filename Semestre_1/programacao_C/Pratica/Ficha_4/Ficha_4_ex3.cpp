#include <stdio.h>

void limparBuffer();
int mostrarMenu();
int lerNumeroPositivo();
int somarWhile(int num);
int somarDoWhile(int num);
int somarFor(int num);

int main(void)
{
    int opcao, num, total;
    int contWhile = 0, contDoWhile = 0, contFor = 0;

    do
    {
        opcao = mostrarMenu();

        if (opcao >= 1 && opcao <= 4)
        {
            num = lerNumeroPositivo();

            if (opcao == 1 || opcao == 4)
            {
                total = somarWhile(num);
                contWhile++;
                printf("[while]    Soma de 1 a %d = %d\n", num, total);
            }
            if (opcao == 2 || opcao == 4)
            {
                total = somarDoWhile(num);
                contDoWhile++;
                printf("[do-while] Soma de 1 a %d = %d\n", num, total);
            }
            if (opcao == 3 || opcao == 4)
            {
                total = somarFor(num);
                contFor++;
                printf("[for]      Soma de 1 a %d = %d\n", num, total);
            }
        }
        else if (opcao != 0)
        {
            printf("Opcao invalida!\n");
        }
    } while (opcao != 0);

    printf("\nNumero de vezes que cada ciclo foi utilizado:\n");
    printf("while:    %d\n", contWhile);
    printf("do-while: %d\n", contDoWhile);
    printf("for:      %d\n", contFor);

    return 0;
}

void limparBuffer()
{
    fflush(stdin);
}

int mostrarMenu()
{
    int opcao;

    printf("\n===== Soma de 1 a n =====\n");
    printf("1 - Somar com while\n");
    printf("2 - Somar com do...while\n");
    printf("3 - Somar com for\n");
    printf("4 - Somar com os tres ciclos\n");
    printf("0 - Sair\n");
    printf("Opcao: ");

    if (scanf("%d", &opcao) != 1)
    {
        opcao = -1;
    }
    limparBuffer();
    return opcao;
}

int lerNumeroPositivo()
{
    int num = 0;
    int ok;

    do
    {
        printf("Escreva um numero inteiro positivo: ");
        ok = scanf("%d", &num);
        limparBuffer();

        if (ok != 1 || num <= 0)
        {
            printf("Numero invalido! ");
            num = 0;
        }
    } while (num <= 0);

    return num;
}

int somarWhile(int num)
{
    int total = 0;
    int i = 1;
    while (i <= num)
    {
        total += i;
        i++;
    }
    return total;
}

int somarDoWhile(int num)
{
    int total = 0;
    int i = 1;
    do
    {
        total += i;
        i++;
    } while (i <= num);
    return total;
}

int somarFor(int num)
{
    int total = 0;
    for (int i = 1; i <= num; i++)
    {
        total += i;
    }
    return total;
}