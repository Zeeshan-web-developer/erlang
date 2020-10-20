/ *
 * @Author: Zeeshan Ahmad
 * @ Date: 2020-10-17 12:34:45
 * @Last Modified by: Zeeshan Ahmad
 * @ Last modified time: 2020-10-17 12:45:48
 * /
#include <stdio.h>
#include <conio.h>
#define size 10
int adj [tsize] [tsize];
int n;
primary () {
    int int;
    int node, start, end;
    diagramGraph ();
    while (1) {
        print ("1.Add a new node \ n");
        print ("2.Delete node \ n");
        print ("3.Dispaly \ n");
        print ("4.Exit \ n");
        print ("Enter preferences:");
        scanf ("% d", with selection);
        change (optional) {
        case 1:
            newNode ();
            fracture;
        case 2:
            susa_node ();
            fracture;
        Case 3:
            display ();
            fracture;
        case 4:
            exit (0);
        default:
            printf ("Please select the correct option \ n");
            fracture;
        }
    }
    find ();
}
 
DrawGraph () {
    int i, tsize_edges, start, end;
 
    printf ("Enter number of nodes:");
    scanf ("% d", & n);
    tsize_edges = n * (n - 1);
 
    of (i = 1; i <= tsize_edges; i ++) {
        print ("Limit% d (0 0) to stop:", i);
        scanf ("% d% d", & start, & end);
        uma ((start == 0) && (end == 0))
            fracture;
        if (start> n || end> ​​n || start <= 0 || end <= 0) {
            printf ("Invalid edge! \ n");
            ;
        } more
            adj [start] [end] = 1;
    }
}
 
display () {
    int i, j;
    of (i = 1; i <= n; i ++) {
        ye (j = 1; j <= n; j ++)
            printf ("% 4d", identifier [i] [j]);
        print ("\ n");
    }
}
 
newNode () {
    int i;
    n ++;
    printf ("Installed node is% d \ n", n);
    of (i = 1; i <= n; i ++) {
        adj [i] [n] = 0;
        adj [n] [i] = 0;
    }
}
 
void Dele_node () {
    printf ("Enter the node you want to delete");
    scanf ("% c", u);
    int i, j;
    if (n == 0) {
        print ("Empty Graph \ n");
        come back;
    }
    if (u> n) {
        printf ("Entered Number Node does not exist \ n");
        come back;
    }
    of (i = u; i <= n - 1; i ++)
        ye (j = 1; j <= n; j ++) {
            adj [j] [i] = adj [j] [i + 1];
            adj [i] [j] = adj [i + 1] [j];
        }
    n--;
}