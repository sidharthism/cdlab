%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<ctype.h>
    #include "deskcalc.tab.h"
%}

%option noyywrap

%%
[0-9]+ {yylval.i = atoi(yytext); return NUM;}
[-+()*/] {return yytext[0];}
[ \t] ;
\n {return 0;}
. {return yytext[0];}
%%