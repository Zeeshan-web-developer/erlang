/*1. Write a program to sort the elements using heap sort.

 * @Author: Zeeshan  Ahmad
 * @Date:   2020-10-17 12:13:17
 * @Last Modified by:   Zeeshan  Ahmad
 * @Last Modified time: 2020-10-17 12:23:44
 */
#include <stdio.h>
#include<stdio.h>
void main()
{
    int array[20], size, i, j, c, root, temp;
 
    printf("\n How Many Elements that u want to sort:");
    scanf("%d", &size);
    printf("Enter the numbers that u want to sort");
    for (i = 0; i < size; i++)
       scanf("%d", &array[i]);
    for (i = 1; i < size; i++)
    {
        c = i;
        do
        {
            root = (c - 1) / 2;             
            if (array[root] < array[c])  
            {
                temp = array[root];
                array[root] = array[c];
                array[c] = temp;
            }
            c = root;
        } while (c != 0);
    }
 
    printf("array array : ");
    for (i = 0; i < size; i++)
        printf("%d\t ", array[i]);
    for (j = size - 1; j >= 0; j--)
    {
        temp = array[0];
        array[0] = array[j];
        array[j] = temp;
        root = 0;
        do 
        {
            c = 2 * root + 1;    /* left sizede of root element */
            if ((array[c] < array[c + 1]) && c < j-1)
                c++;
            if (array[root]<array[c] && c<j)    /* again rearrange to max array array */
            {
                temp = array[root];
                array[root] = array[c];
                array[c] = temp;
            }
            root = c;
        } while (c < j);
    } 
    printf("\n The sorted array is  as: ");
    for (i = 0; i < size; i++)
       printf("\t %d", array[i]);
    
}