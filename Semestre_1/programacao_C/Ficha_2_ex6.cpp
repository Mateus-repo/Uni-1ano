#include <stdio.h>
#include <conio.h>
#include <string.h>

char *procurarMes(int num);

int main(void)
{
    int num;
    printf("Insira o numero do mes (1 a 12) - ");
    scanf("%d", &num);
    printf("\n");
    if (num < 1 || num > 12)
    {
        printf("Numero invalido");
    }
    else
    {
        printf("O mes %d e %s", num, procurarMes(num));
    }
    return 0;
}

char *procurarMes(int num){
    static char meses[12][32];
    strcpy(meses[0], "janeiro");
    strcpy(meses[1], "fevereiro");
    strcpy(meses[2], "marco");
    strcpy(meses[3], "abril");
    strcpy(meses[4], "maio");
    strcpy(meses[5], "junho");
    strcpy(meses[6], "julho");
    strcpy(meses[7], "agosto");
    strcpy(meses[8], "setembro");
    strcpy(meses[9], "outubro");
    strcpy(meses[10], "novembro");
    strcpy(meses[11], "dezembro");
    return meses[num-1];
}
