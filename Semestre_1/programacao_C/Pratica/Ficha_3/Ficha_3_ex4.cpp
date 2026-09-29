#include <stdio.h>
#include <conio.h>

struct registo_dados
{
    int total = 0;
    long long soma = 0;
    int total_positivos = 0;
    int total_negativos = 0;
};

void pedirDados(registo_dados *dados);

int main(void)
{
    registo_dados dados;
    pedirDados(&dados);
    printf("Total de numeros introduzidos: %d\n", dados.total);
    printf("Soma dos numeros introduzidos: %lld\n", dados.soma);
    printf("Media dos numeros introduzidos: %.2f\n", (dados.total > 0) ? (double)dados.soma / dados.total : 0.0);
    printf("Total de numeros positivos: %d\n", dados.total_positivos);
    printf("Total de numeros negativos: %d\n", dados.total_negativos);
    return 0;
}

void pedirDados(registo_dados *dados)
{
    long long temp = 0;
    printf("Escreva quantos numeros inteiros deseja introduzir:\n");
    scanf("%d", &dados->total);
    for (int i = 0; i < dados->total; i++)
    {
        printf("Escreva o %d numero - ", i + 1);
        scanf("%lld", &temp);
        if ((int)temp != 0)
        {
            dados->soma += temp;
            dados->total_negativos += (((int)temp < 0) ? 1 : 0);
            dados->total_positivos += (((int)temp > 0) ? 1 : 0);
        }else
        {
            printf("\nEntrada invalida. %d\n", (int)temp);
            i--;
        }
    }
    
}
