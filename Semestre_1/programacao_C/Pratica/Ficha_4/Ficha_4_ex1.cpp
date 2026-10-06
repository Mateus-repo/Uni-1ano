#include <stdio.h>
#include <conio.h>

int lerNumero();
void leDadosRetangulo(int *base, int *altura);
int areaRetangulo(int base, int altura);

int main(void)
{
    int base, altura, area;

    leDadosRetangulo(&base, &altura);
    area = areaRetangulo(base, altura);

    printf("A area do retangulo e %d\n", area);
    return 0;
}

int lerNumero()
{
    int num;
    scanf("%d", &num);
    return num;
}

void leDadosRetangulo(int *base, int *altura)
{
    printf("Escreva a base do retangulo - ");
    *base = lerNumero();
    printf("Escreva a altura do retangulo - ");
    *altura = lerNumero();
}

int areaRetangulo(int base, int altura)
{
    return base * altura;
}