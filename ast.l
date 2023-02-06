%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "ast.tab.h"
int LineNo=1;
%}

%option noyywrap

identifier [a-zA-Z][_a-zA-Z]*
number [0-9]+

%%
{identifier} return VARIABLE;
{number} return NUM;

[ \t] ;
\n LineNo++;
. return yytext[0];
%%