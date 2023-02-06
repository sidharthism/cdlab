%{
#include<string.h>
#include<stdio.h>
#include <stdlib.h>

extern int LineNo;
extern char* yytext;
extern FILE *yyin;
extern int yylex();

struct quad{
    char op[5];
    char arg1[10];
    char arg2[10];
    char result[10];
}QUAD[30];

int Index=0,tIndex=0;
int yyerror();

void AddQuadruple(char op[5],char arg1[10],char arg2[10],char result[10]) {
    // Add code here to add a new quadruple to the QUAD array
    strcpy(QUAD[Index].op,op);
    strcpy(QUAD[Index].arg1,arg1);
    strcpy(QUAD[Index].arg2,arg2);
    sprintf(QUAD[Index].result,"t%d",tIndex++);
    strcpy(result,QUAD[Index++].result);
}%}

%union {
    char var[10];
}

%token <var> NUM VARIABLE
%type <var> START EXPR PRIMARY

%left '-' '+'
%left '*' '/'

%%
START: PRIMARY '=' EXPR{
    strcpy(QUAD[Index].op,"=");
    strcpy(QUAD[Index].arg1,$3);
    strcpy(QUAD[Index].arg2,"");
    strcpy(QUAD[Index].result,$1);
    strcpy($$,QUAD[Index++].result);
}
    ;
EXPR: EXPR '+' EXPR {AddQuadruple("+",$1,$3,$$);}
    | EXPR '-' EXPR {AddQuadruple("-",$1,$3,$$);}
    | EXPR '*' EXPR {AddQuadruple("*",$1,$3,$$);}
    | EXPR '/' EXPR {AddQuadruple("/",$1,$3,$$);}
    | '(' EXPR ')' {strcpy($$,$2);}
    | PRIMARY
    ;
PRIMARY: VARIABLE {strcpy($$, yytext);}
       | NUM {strcpy($$, yytext);}
       ;
%%

int main(){
    FILE *fp;
    fp=fopen("ast.txt","r");
    if(!fp){
        printf("\n File not found");
        exit(0);
    }
    yyin=fp;
    yyparse();
    printf("\n\t\t Pos Operator\tArg1 \tArg2 \tResult");
    for(int i=0; i < Index;i++)
        printf("\n\t\t %d\t %s\t %s\t%s\t%s", i, QUAD[i].op, QUAD[i].arg1, QUAD[i].arg2, QUAD[i].result);
    printf("\n\n");
    return 0;
}

int yyerror(){
    printf("\n Error on line no:%d %s",LineNo, yytext);
}