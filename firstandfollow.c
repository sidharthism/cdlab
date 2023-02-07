#include <stdio.h>
#include <math.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

char prod[10][10], f[10];
int n, m = 0;

void follow(char c);
void first(char c);

int main()
{
    int z;
    char c, ch;
    printf("Enter the no of productions : \n");
    scanf("%d", &n);
    printf("Enter the productions:\n");
    for (int i = 0; i < n; i++)
        scanf("%s%c", prod[i], &ch);
    do
    {
        m = 0;
        printf("Enter a variable whose first & follow is to be found:");
        scanf("%c", &c);
        first(c);
        printf("First(%c)={", c);
        for (int i = 0; i < m; i++)
            printf("%c", f[i]);
        printf("}\n");
        // Reset the buffer
        strcpy(f, " ");
        m = 0;
        follow(c);
        printf("Follow(%c)={", c);
        for (int i = 0; i < m; i++)
            printf("%c", f[i]);
        printf("}\n");
        printf("Want to continue or not(1/0) ? ");
        scanf("%d%c", &z, &ch);
    } while (z == 1);
    return 0;
}

void first(char c)
{
    // If c is a terminal
    if (!isupper(c))
        f[m++] = c;
    // If c is a not a terminal
    else
        // For each prod
        for (int i = 0; i < n; i++)
            // If c is on left of prod
            if (prod[i][0] == c)
                // If # prod
                if (prod[i][2] == '#')
                    follow(prod[i][0]);
                // If right prod symbol is a terminal
                else if (islower(prod[i][2]))
                    f[m++] = prod[i][2];
                // If right prod symbol is a non terminal
                else
                    first(prod[i][2]);
}

void follow(char c)
{
    // Follow of start symbol is $
    if (prod[0][0] == c)
        f[m++] = '$';
    // For remaining symbols, for each prod
    for (int i = 0; i < n; i++)
        // For each symbol on right side of prod
        for (int j = 2; j < strlen(prod[i]); j++)
            if (prod[i][j] == c)
            {
                // if symbol is not at last, find first of next
                if (prod[i][j + 1] != '\0')
                    first(prod[i][j + 1]);
                // if prod is last, prod is not the left side one, find follow
                if (prod[i][j + 1] == '\0' && c != prod[i][0])
                    follow(prod[i][0]);
            }
}