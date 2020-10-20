/*
 * @Author: Zeeshan  Ahmad
 * @Date:   2020-10-17 12:24:55
 * @Last Modified by:   Zeeshan  Ahmad
 * @Last Modified time: 2020-10-17 12:27:46
 */
#include <stdio.h>
    void main ()
    {
 
        int arr[30];
 
        int i, j, a, size;
        printf("How many elements u want to Sort \n");
        scanf("%d", &size);
 
        printf("Enter Array Elements \n");
        for (i = 0; i < size; ++i)
	        scanf("%d", &arr[i]);
 
 
        for (i = 0; i < size; ++i) 
        {
            for (j = i + 1; j < size; ++j) 
            {
                if (arr[i] < arr[j]) 
                {
                    a = arr[i];
                    arr[i] = arr[j];
                    arr[j] = a;
                }
            }
        }
 
        printf("Resultant Array is as");
 
        for (i = 0; i < size; ++i) 
        {
            printf("%d\n", arr[i]);
        }
 
    }