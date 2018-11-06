/*******************************************************************************
YACC FILE for the calculator
*******************************************************************************/

%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyerror(const char *p) { printf("%s encountered\n",p); return 1; }
int reg[100] = { 0 };
%}


%token NUMBER VARIABLE NEWLINE EXIT
%right '='
%left   '+' '-'
%left   '*' '/'

%start lines


%%

lines: /*empty*/ 
     |  lines stmt NEWLINE { printf("Result::%d\n",$2); }
     | EXIT  { exit(0); }
     ;

stmt: exp { $$ = $1; }
    | VARIABLE '=' exp {  reg[$1] = $3; $$ = $3; printf("Index = %d, Val: %d\n",$1,$3); }
    ;

exp:   exp '+' exp   { $$ = $1 + $3; }
   
     | exp '-' exp   { $$ = $1 - $3; }

     | exp '*' exp   { $$ = $1 * $3; } 

     | exp '/' exp   { if( $3 == 0 ) {  yyerror("Divide by Zero Error"); $$ = -1; } else { $$ = $1 / $3 ; } } 

     | '-' exp %prec '*' { $$ = 0 - $1; }

     | '(' exp ')'   { $$ = $2; }
   
     | VARIABLE      { $$ = reg[$1]; }

     | NUMBER        { $$ = $1; }

     ;
%%

int yywrap()
{
    return 1;
}
int main()
{
    yyparse();
}

