#include <stdio.h>
#include <string.h>
char result[20][20], temp[3], states[20][20];

void add_state(char s[3], int i)
{
    strcpy(result[i], s);
}

void display(int n)
{
    printf("\nEpsilon closure of %s = {", temp);
    for (int i = 0; i < n; i++)
        printf(" %s", result[i]);
    printf(" } \n");
}

int main()
{
    char state[3], state1[3], input[3], state2[3];
    int end, n, j = 0;
    FILE *INPUT = fopen("einput.txt", "r");
    printf("\nEnter the no of states: ");
    scanf("%d", &n);
    printf("\nEnter the states:");

    for (int i = 0; i < n; i++)
        scanf("%s", states[i]);

    for (int i = 0; i < n; i++)
    {
        j = 0;
        strcpy(state, states[i]);
        strcpy(temp, state);
        add_state(state, j++);
        while (1)
        {
            end = fscanf(INPUT, "%s%s%s", state1, input, state2);
            if (end == EOF)
                break;
            if (strcmp(state, state1) == 0)
            {
                if (strcmp(input, "e") == 0)
                {
                    add_state(state2, j++);
                    strcpy(state, state2);
                }
            }
        }
        display(j);
        rewind(INPUT);
    }
    return 0;
}

// q0 0 q0
// q0 1 q1
// q0 e q1
// q1 1 q2
// q1 e q2