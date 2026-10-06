#include <stdio.h>
#include <ctype.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

int leNumero();
char menu(int nTriangulo, int nRetangulo, int nCirculo, int nQuadrado);
void leDadosTriangulo(int *base, int *altura);
double areaTriangulo(int base, int altura);
int areaRetangulo(int base, int altura);
int areaQuadrado(int lado);
double areaCirculo(int raio);

int main(void)
{
    char op;
    int nTriangulo = 0, nRetangulo = 0, nCirculo = 0, nQuadrado = 0;
    int base, altura, lado, raio;

    do
    {
        op = menu(nTriangulo, nRetangulo, nCirculo, nQuadrado);

        switch (op)
        {
        case 'T':
            leDadosTriangulo(&base, &altura);
            printf("Area do triangulo: %.2f\n", areaTriangulo(base, altura));
            nTriangulo++;
            break;
        case 'R':
            printf("Escreva a base do retangulo - ");
            base = leNumero();
            printf("Escreva a altura do retangulo - ");
            altura = leNumero();
            printf("Area do retangulo: %d\n", areaRetangulo(base, altura));
            nRetangulo++;
            break;
        case 'Q':
            printf("Escreva o lado do quadrado - ");
            lado = leNumero();
            printf("Area do quadrado: %d\n", areaQuadrado(lado));
            nQuadrado++;
            break;
        case 'C':
            printf("Escreva o raio do circulo - ");
            raio = leNumero();
            printf("Area do circulo: %.2f\n", areaCirculo(raio));
            nCirculo++;
            break;
        case 'F':
            printf("A sair...\n");
            break;
        default:
            printf("Opcao invalida!\n");
        }
    } while (op != 'F');

    return 0;
}

int leNumero()
{
    int num;
    do
    {
        scanf("%d", &num);
        if (num <= 0)
        {
            printf("Por favor, insira um numero inteiro positivo: ");
        }
    } while (num <= 0);
    return num;
}

char menu(int nTriangulo, int nRetangulo, int nCirculo, int nQuadrado)
{
    char op;
    printf("\n Calculo de Areas\n");
    printf(" Triangulo (Num Vezes): %d\n", nTriangulo);
    printf(" Retangulo (Num Vezes): %d\n", nRetangulo);
    printf(" Circulo   (Num Vezes): %d\n", nCirculo);
    printf(" Quadrado  (Num Vezes): %d\n", nQuadrado);
    printf("\n OPCOES\n");
    printf(" (T)riangulo (R)etangulo (Q)uadrado (C)irculo (F)im\n");
    printf(" Selecione opcao: ");
    scanf(" %c", &op);
    return toupper(op);
}

void leDadosTriangulo(int *base, int *altura)
{
    printf("Escreva a base do triangulo - ");
    *base = leNumero();
    printf("Escreva a altura do triangulo - ");
    *altura = leNumero();
}

double areaTriangulo(int base, int altura)
{
    return (base * altura) / 2.0;
}

int areaRetangulo(int base, int altura)
{
    return base * altura;
}

int areaQuadrado(int lado)
{
    return lado * lado;
}

double areaCirculo(int raio)
{
    return M_PI * pow(raio, 2);
}