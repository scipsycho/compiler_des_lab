/*******************************************************************************
YACC FILE for the calculator
*******************************************************************************/

%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "global.h"

int reg[100] = { 0 };
int isSet[100] = { 0 };
int yylex();
int yyerror(const char *p) { printf("%s encountered\n",p); return 1; }
int i;
%}


%token INTEGER VARIABLE NEWLINE EXIT INFO EXP
%right '='
%left   '+' '-'
%left   '*' '/'
%left UMINUS 

%start lines


%%

lines: /*empty*/ 
     |  lines stmt NEWLINE { printf("%d\n>> ",$2); }
     ;

stmt:  exp { $$ = $1; }
     | VARIABLE '=' exp {  reg[$1] = $3; $$ = $3; isSet[$1] = 1; printf("((%s = %d)) ", varNames[$1], $3); }
     | EXIT  { exit(0); }
     | INFO {
                        printf("%*s | %*s\n",15,"Variable",15,"Value");
                        i = 0;
                        while(varNames[i] != NULL && isSet[i] )
                        {               
                            printf("%*s | %*d\n",15,varNames[i],15,reg[i]);
                            i++;
                        }
            }
    ;

exp:   exp '+' exp   { $$ = $1 + $3; }
   
     | exp '-' exp   { $$ = $1 - $3; }

     | exp '*' exp   { $$ = $1 * $3; } 

     | exp '/' exp   { if( $3 == 0 ) {  yyerror("Divide by Zero Error"); $$ = -1; return 1; } else { $$ = $1 / $3 ; } } 

     | '-' exp %prec UMINUS { $$ = 0 - $2; }

     | '(' exp ')'   { $$ = $2; }

     | EXP '(' exp ',' exp ')'  { $$ = pow($3,$5); } 
   
     | VARIABLE      { if( isSet[$1] == 0 ) { yyerror("Variable not initialized"); $$ = -1; return 1; } else $$ = reg[$1]; }

     | INTEGER        { $$ = $1; }

     ;
%%

int yywrap()
{
    return 1;
}
int main()
{
    printf("Calculator built using YACC and LEX\n");
    printf("Author: Dharmesh Singh (@scipsycho)\n");
    printf("Reserved keywords: exit, quit, info, exp\n");
    printf("Supported operators: \n");
    printf("Addition:    + \n");
    printf("Subtraction: - \n");
    printf("Multiplication: * \n");
    printf("Division: / \n");
    printf("Exponentiation: exp(op1,op2) \n");
    printf("\n\n>> ");
    while(yyparse()==1)
    {
        yylex();
        printf(">> ");
    }

}

