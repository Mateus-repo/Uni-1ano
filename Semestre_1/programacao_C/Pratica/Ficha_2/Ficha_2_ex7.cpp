#include <stdio.h>
#include <conio.h>

void fazerCalculo(char operador, int num1, int num2);
void pedirDados(int *num1, int *num2);
void pedirOperador(char *operador);

int main(void)
{
    int num1, num2;
    char operador;

    pedirDados(&num1, &num2);
    pedirOperador(&operador);
    fazerCalculo(operador, num1, num2);
}

void fazerCalculo(char operador, int num1, int num2)
{
    switch (operador)
    {
    case '+':
        printf("Soma de %d e %d e igual a %d\n", num1, num2, num1 + num2);
        break;
    case '-':
        printf("Subtracao de %d e %d e igual a %d\n", num1, num2, num1 - num2);
        break;
    case '*':
    case 'x':
    case 'X':
        printf("Multiplicacao de %d e %d e igual a %d\n", num1, num2, num1 * num2);
        break;
    case '/':
        printf("Divisao de %d e %d e igual a %f\n", num1, num2, (num1 * 1.0) / (num2 * 1.0));
        break;
    default:
        printf("Operador invalido\n");
        break;
    }
}

void pedirDados(int *num1, int *num2)
{
    printf("Escreva o primeiro numero - ");
    scanf("%d", num1);
    printf("Escreva o segundo numero - ");
    scanf("%d", num2);
}

void pedirOperador(char *operador)
{
    printf("Escreva o operador - ");
    scanf("%*c");
    scanf("%c", operador);
}
