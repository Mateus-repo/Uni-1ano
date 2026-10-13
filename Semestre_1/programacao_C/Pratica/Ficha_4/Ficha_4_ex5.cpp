#include <stdio.h>
#include <conio.h>
#include <math.h>
#include <stdlib.h>

void menu();
double leNumero();
double binomioDiscriminante(double a, double b, double c);
double zerosReais(double a, double b, double c, double *x1, double *x2);

    int main(void)
    {
        int op;
        double a, b, c, x1, x2;
        double numZeros;

        do
        {
            menu();
            printf("Escolha uma opcao: ");
            scanf("%d", &op);
            if (op == 1)
            {
                do{
                    printf("Escreva o valor de a - ");
                    a = leNumero();
                    if(a == 0)
                    {
                        printf("O valor de a nao pode ser zero. Tente novamente.\n");
                    }  
                }while(a == 0);
                printf("Escreva o valor de b - ");
                b = leNumero();
                printf("Escreva o valor de c - ");
                c = leNumero();

                numZeros = zerosReais(a, b, c, &x1, &x2);

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
            else if (op != 0)
            {
                printf("Opcao invalida!\n");
            }
        } while (op != 0);

        return 0;
    }

    void menu()
    {
        printf("Menu:\n");
        printf("1. Calcular zeros reais de uma equacao do 2 grau\n");
        printf("0. Sair\n");
    }

    double leNumero()
    {
        double num;
        scanf("%lf", &num);
        return num;
    }

    double binomioDiscriminante(double a, double b, double c)
    {
        return b * b - 4 * a * c;
    }

    double zerosReais(double a, double b, double c, double *x1, double *x2)
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