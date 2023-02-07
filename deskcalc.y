%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<ctype.h>
    #include "deskcalc.tab.h"
    extern int yylex();
    int yyerror(const char *err);
%}

%union
{
    int i;
}

%token <i> NUM
%type <i> S E T F

%%
S : E {printf("Result: %d", $1);}
  ;
E : E '+' T {$$ = $1 + $3;}
  | E '-' T {$$ = $1 - $3;}
  | T {$$ = $1;}
  ;
T : T '*' F {$$ = $1 * $3;}
  | T '/' F {$$ = $1 / $3;}
  | F {$$ = $1;}
  ;
F : '(' E ')' {$$ = $2;}
  | NUM {$$ = $1;}
  ;
%%

int main()
{
    printf("Enter any arithmetic expression: ");
    yyparse();
    return 0;
}

int yyerror(const char *err)
{
    printf("%s\n", err);
}