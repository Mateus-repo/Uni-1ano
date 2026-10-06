#include <stdio.h>
#include <conio.h>
#include <math.h>

void mostrarMenu();
int lerNumero();
void leDadosRetangulo();
void leDadosTriangulo();
void leDadosQuadrado();
void leDadosCirculo();
int areaRetangulo(int base, int altura);
int areaTriangulo(int base, int altura);
int areaQuadrado(int lado);
int areaCirculo(int raio);

int main(void)
{
    int op = 0;
    do{
        mostrarMenu();
        op = lerNumero();
        switch(op){
            case 1:
                leDadosRetangulo();
                break;
            case 2:
                leDadosTriangulo();
                break;
            case 3:
                leDadosQuadrado();
                break;
            case 4:
                leDadosCirculo();
                break;
            case 5:
                printf("A sair...\n");
                break;
            default:
                printf("Opcao invalida!\n");
        }
    }while (op != 5);
    return 0;
}

void mostrarMenu()
{
    printf("Escolha uma opcao:\n");
    printf("1 - Calcular area do retangulo\n");
    printf("2 - Calcular area do triangulo\n");
    printf("3 - Calcular area do quadrado\n");
    printf("4 - Calcular area do circulo\n");
    printf("5 - Sair\n");
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

void leDadosRetangulo()
{
    int base, altura;
    printf("Escreva a base do retangulo - ");
    base = lerNumeroPositivo();
    printf("Escreva a altura do retangulo - ");
    altura = lerNumeroPositivo();
    printf("Área do retangulo: %d\n", areaRetangulo(base, altura));
}

void leDadosTriangulo()
{
    int base, altura;
    printf("Escreva a base do triangulo - ");
    base = lerNumeroPositivo();
    printf("Escreva a altura do triangulo - ");
    altura = lerNumeroPositivo();
    printf("Área do triangulo: %d\n", areaTriangulo(base, altura));
}

void leDadosQuadrado()
{
    int lado;
    printf("Escreva o lado do quadrado - ");
    lado = lerNumeroPositivo();
    printf("Área do quadrado: %d\n", areaQuadrado(lado));
}

void leDadosCirculo()
{
    int raio;
    printf("Escreva o raio do circulo - ");
    raio = lerNumeroPositivo();
    printf("Área do circulo: %d\n", areaCirculo(raio));
}

int areaRetangulo(int base, int altura)
{
    return base * altura;
}

int areaTriangulo(int base, int altura)
{
    return (base * altura) / 2;
}

int areaQuadrado(int lado)
{
    return lado * lado;
}

int areaCirculo(int raio)
{
    return M_PI * pow(raio, 2);
}
