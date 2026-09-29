#include <stdio.h>
#include <conio.h>

struct Data
{
    int dia;
    int mes;
    int ano;
};

int verificarValidadeData(struct Data data);

int main(void)
{
    struct Data data;
    printf("Escreva o dia - ");
    scanf("%d", &data.dia);
    printf("Escreva o mes - ");
    scanf("%d", &data.mes);
    printf("Escreva o ano - ");
    scanf("%d", &data.ano);

    if (verificarValidadeData(data))
        printf("Data valida\n");
    else
        printf("Data invalida\n");
}

int verificarValidadeData(struct Data data)
{
    
    if (data.ano < 0)
        return 0;
    if (data.mes < 1 || data.mes > 12)
        return 0;
    if (data.dia < 1 || data.dia > 31)
        return 0;

    if (data.mes == 2)
    {
        if ((data.ano % 4 == 0 && data.ano % 100 != 0) || (data.ano % 400 == 0))
        {
            if (data.dia > 29)
                return 0;
        }
        else
        {
            if (data.dia > 28)
                return 0;
        }
    }

    if (data.mes == 4 || data.mes == 6 || data.mes == 9 || data.mes == 11)
    {
        if (data.dia > 30)
            return 0;
    }

    return 1;
}