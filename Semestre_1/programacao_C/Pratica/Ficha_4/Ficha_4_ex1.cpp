#include <stdio.h>
#include <conio.h>

int lerNumero();
int leDadosRetangulo();
int areaRetangulo(int base, int altura);

int main(void)
{
    areaRetangulo(leDadosRetangulo());
    return 0;
}

int lerNumero()
{
    int num;
    scanf("%d", &num);
    return num;
}

int leDadosRetangulo()
{
    int base, altura;
    printf("Escreva a base do retangulo - ");
    base = lerNumero();
    printf("Escreva a altura do retangulo - ");
    altura = lerNumero();
    return (base, altura);
}

int areaRetangulo(int base, int altura)
{
    return base * altura;
}