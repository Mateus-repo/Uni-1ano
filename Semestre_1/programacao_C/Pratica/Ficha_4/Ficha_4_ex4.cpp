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
double binomioDiscriminante(double a, double b, double c);
int zerosReais(double a, double b, double c, double *x1, double *x2);
void calcularZerosReais();

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
            calcularZerosReais();
            break;
        case 6:
            printf("%d + %d = %d\n", n1, n2, soma(n1, n2));
            printf("%d - %d = %d\n", n1, n2, subtracao(n1, n2));
            printf("%d - %d = %d\n", n2, n1, subtracao(n2, n1));
            mostrarRaiz(n1);
            mostrarRaiz(n2);
            printf("%d ^ %d = %.2f\n", n1, n2, potencia(n1, n2));
            printf("%d ^ %d = %.2f\n", n2, n1, potencia(n2, n1));
            calcularZerosReais();
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
    printf(" 5 - Numero de zeros reais de uma equacao do 2 grau\n");
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

double binomioDiscriminante(double a, double b, double c)
{
    return b * b - 4 * a * c;
}

int zerosReais(double a, double b, double c, double *x1, double *x2)
{
    double delta = binomioDiscriminante(a, b, c);
    if (delta < 0)
    {
        return 0;
    }
    else if (delta == 0)
    {
        *x1 = -b / (2 * a);
        return 1;
    }
    else
    {
        *x1 = (-b + sqrt(delta)) / (2 * a);
        *x2 = (-b - sqrt(delta)) / (2 * a);
        return 2;
    }
}

void calcularZerosReais(){
    double a, b, c, x1, x2;
    do
    {
        printf("Escreva o valor de a - ");
        a = (double)leNumero();
        if (a == 0)
        {
            printf("O valor de a nao pode ser zero. Tente novamente.\n");
        }
    }while(a == 0);   
    printf("Escreva o valor de b - ");
    b = (double)leNumero();
    printf("Escreva o valor de c - ");
    c = (double)leNumero();
    int numZeros = zerosReais(a, b, c, &x1, &x2);
    if (numZeros == 0)
    {
        printf("Nao existem zeros reais!\n");
    }
    else if (numZeros == 1)
    {
        printf("Existe um zero real: %.2lf\n", x1);
    }
    else
    {
        printf("Existem dois zeros reais: %.2lf e %.2lf\n", x1, x2);
    }
    }