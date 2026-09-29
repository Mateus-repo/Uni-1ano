#include <stdio.h>
#include <conio.h>

struct registo_dados
{
    int total = 0;
    int soma = 0;
    int total_positivos = 0;
    int total_negativos = 0;
};

void pedirDados(registo_dados *dados);

int main(void)
{
    registo_dados dados;
    pedirDados(&dados);
    printf("Total de numeros introduzidos: %d\n", dados.total);
    printf("Soma dos numeros introduzidos: %d\n", dados.soma);
    printf("Media dos numeros introduzidos: %.2f\n", (float)dados.soma / dados.total);
    printf("Total de numeros positivos: %d\n", dados.total_positivos);
    printf("Total de numeros negativos: %d\n", dados.total_negativos);
    return 0;
}

void pedirDados(registo_dados *dados)
{
    int i = 0;
    int temp = 0;
    do{
        printf("Escreva o %d numero - ", i + 1);
        scanf("%d", &temp);
        if(temp != 0){
            dados->soma += temp;
            dados->total_negativos += ((temp < 0) ? 1 : 0);
            printf("Total de numeros negativos introduzidos: %d || %d\n", ((temp < 0) ? 1 : 0), dados->total_negativos);
            dados->total_positivos += ((temp > 0) ? 1 : 0);
            printf("Total de numeros positivos introduzidos: %d || %d\n", ((temp > 0) ? 1 : 0), dados->total_positivos);
            i++;
        }
    } while (temp > 0);
    dados->total = i;
}
