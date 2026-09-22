#include <stdio.h>
#include <conio.h>
#define COUNT 3

int main(void)
{
    int nums[COUNT];
    int estado = 0;
    for (int i = 0; i < COUNT; i++)
    {
        printf("Insira o %d numero - ", i+1);
        scanf("%d", &nums[i]);
    }
    printf("\n");
    for(int i = 0; i < COUNT - 1; i++){
        if(nums[i]==nums[i+1]){
            estado = 1;
            break;
        }else if (i!=0){
            if(nums[i]==nums[i-1]){
                estado = 1;
                break;
            }
        }
    }
    printf("Os numeros ");
    if (estado)
    {
        printf("nao "); 
    }
    printf("sao todos diferentes\n");
}
