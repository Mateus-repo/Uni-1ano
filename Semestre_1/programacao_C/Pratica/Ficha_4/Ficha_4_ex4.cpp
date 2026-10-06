#include <stdio.h>
#include <conio.h>
#include <math.h>

int leNumero();
int menu();
int soma(int n1, int n2);
int subtracao(int n1, int n2);
double raizQuadrada(int n);
double potencia(int base, int expoente);
void mostrarRaiz(int n);

int main(void)
{
    int op, n1, n2;

    do
    {
        op = menu();
        if(op == 3){
            printf("Escreva um numero (n1) - ");
            n1 = leNumero();
        }else if (op >= 1 && op <= 6)
        {
            printf("Escreva o primeiro numero (n1) - ");
            n1 = leNumero();
            printf("Escreva o segundo numero (n2) - ");
            n2 = leNumero();
            printf("\n");
        }

        switch (op)
        {
        case 1:
            printf("%d + %d = %d\n", n1, n2, soma(n1, n2));
            break;
        case 2:
            printf("%d - %d = %d\n", n1, n2, subtracao(n1, n2));
            break;
        case 3:
            mostrarRaiz(n1);
            break;
        case 4:
            printf("%d ^ %d = %.2f\n", n1, n2, potencia(n1, n2));
            break;
        case 5:
            printf("%d ^ %d = %.2f\n", n2, n1, potencia(n2, n1));
            break;
        case 6:
            printf("%d + %d = %d\n", n1, n2, soma(n1, n2));
            printf("%d - %d = %d\n", n1, n2, subtracao(n1, n2));
            mostrarRaiz(n1);
            mostrarRaiz(n2);
            printf("%d ^ %d = %.2f\n", n1, n2, potencia(n1, n2));
            printf("%d ^ %d = %.2f\n", n2, n1, potencia(n2, n1));
            break;
        case 0:
            printf("A sair...\n");
            break;
        default:
            printf("Opcao invalida!\n");
        }
    } while (op != 0);

    return 0;
}

int leNumero()
{
    int num;
    scanf("%d", &num);
    return num;
}

int menu()
{
    int op;
    printf("\n===== Operacoes =====\n");
    printf(" 1 - Soma\n");
    printf(" 2 - Subtracao\n");
    printf(" 3 - Raiz quadrada\n");
    printf(" 4 - Potencia (n1 elevado a n2)\n");
    printf(" 5 - Potencia (n2 elevado a n1)\n");
    printf(" 6 - Todas as operacoes\n");
    printf(" 0 - Sair\n");
    printf(" Selecione opcao: ");
    scanf("%d", &op);
    return op;
}

int soma(int n1, int n2)
{
    return n1 + n2;
}

int subtracao(int n1, int n2)
{
    return n1 - n2;
}

double raizQuadrada(int n)
{
    return sqrt(n);
}

double potencia(int base, int expoente)
{
    return pow(base, expoente);
}

void mostrarRaiz(int n)
{
    if (n < 0)
    {
        printf("Raiz quadrada de %d: impossivel (numero negativo)\n", n);
    }
    else
    {
        printf("Raiz quadrada de %d = %.2f\n", n, raizQuadrada(n));
    }
}