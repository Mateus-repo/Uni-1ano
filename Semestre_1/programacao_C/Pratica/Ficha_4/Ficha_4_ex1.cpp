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

int lerNumeroPositivo()
{
    int num;
    do
    {
        scanf("%d", &num);
        if (num < 0)
        {
            printf("Por favor, insira um numero positivo.\n");
        }
    } while (num < 0);
    return num;
}
void leDadosRetangulo(int *base, int *altura)
{
    printf("Escreva a base do retangulo - ");
    *base = lerNumeroPositivo();
    printf("Escreva a altura do retangulo - ");
    *altura = lerNumeroPositivo();
}

int areaRetangulo(int base, int altura)
{
    return base * altura;
}