#include <stdio.h>
#include <conio.h>

#define MAX 3

void pedirDados(int *num[], int max);
void organizarArray(int *num[], int max);
void mostrarArray(int *num[], int max);

int main(void){
    int num[MAX];
    pedirDados(&num, MAX);
    organizarArray(&num, MAX);
    mostrarArray(&num, MAX);
    return 0;
}

void pedirDados(int *num[], int max){
    for(int i = 0; i < max; i++){
        printf("Escreva o %d numero - ", i + 1);
        scanf("%d", num[i]);
    }
}

void organizarArray(int *num[], int max){
    int aux;
    for(int i = 0; i < max; i++){
        for(int j = 0; j < max - 1; j++){
            if(*num[j] > *num[j + 1]){
                aux = *num[j];
                *num[j] = *num[j + 1];
                *num[j + 1] = aux;
            }
        }
    }
}

void mostrarArray(int *num[], int max)
{
    printf("Array organizado: ");
    for (int i = 0; i < max; i++)
    {
        printf("%d ", *num[i]);
    }
    printf("\n");
}