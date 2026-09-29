#include <stdio.h>
#include <conio.h>
#include <stdlib.h>

int verificarTriangulo(int num[], int tamanho);
int numIgualdades(int num[], int tamanho);
int angulosTriangulo(int num[], int tamanho);
int tipoTriangulo(int num[], int tamanho, int igualdades);

int main(void)
{
    int linhas[3];
    for (int i = 0; i < 3; i++)
    {
        printf("Insira o comprimento da linha %d - ", i+1);
        scanf("%d", &linhas[i]);
    }
    printf("\n");
    if (verificarTriangulo(linhas, sizeof(linhas)/sizeof(linhas[0])))
    {
        printf("As tres linhas formam um triangulo ");
        int igualdades = numIgualdades(linhas, sizeof(linhas)/sizeof(linhas[0]));
        tipoTriangulo(linhas, sizeof(linhas)/sizeof(linhas[0]), igualdades);
    }
    else
    {
        printf("As tres linhas nao formam um triangulo ");
    }
}

int verificarTriangulo(int num[], int tamanho)
{
    if(tamanho!=3)
    {
        return 0;
    }
    if ((abs(num[0]-num[1])<num[2])&&(num[2]<(num[0]+num[1])))
    {
        return 1;
    }
    return 0;
}

int numIgualdades(int num[], int tamanho)
{
    int igualdades = 0;
    for(int i = 0; i < tamanho-1; i++)
    {
        for(int j = i+1; j < tamanho; j++)
        {
            if(num[i]==num[j])
            {
                igualdades++;
            }
        }
    }
    return igualdades;
}

int angulosTriangulo(int num[], int tamanho){
    if(!verificarTriangulo(num, tamanho))
    {
        return -1;
    }
    float angulos[3]=[0.0, 0.0, 0.0];
    int igualdades = numIgualdades(num, sizeof(num)/sizeof(num[0]));
    if(igualdades==3){
        for(int i = 0; i < 3; i++){
            angulos[i]=60.0;
        }
    }else{
    /*
        arccos(alpha) = (b^2 + c^2 - a^2)/(2 * b * c)
        arccos(beta) = (a^2 + c^2 - b^2)/(2 * a * c)
        angulo c = 180 - aplha - beta
    */
    }
    
}

int tipoTriangulo(int num[], int angulos[], int tamanho, int igualdades)
{
    if(!verificarTriangulo(num, tamanho))
    {
        return -1;
    }
    if(igualdades==3)
    {
        printf("equilatero");
        return 3;
    }
    if(igualdades==1)
    {
        printf("isosceles");
        return 1;
    }
    if(igualdades==0)
    {
        printf("escaleno");
        return 0;
    }
    return -2;
}
