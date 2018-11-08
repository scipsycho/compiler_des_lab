%{
    
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//in bytes
#define MAX_MEMORY 1000

char *varNames[MAX_MEMORY];
int   varAddr[MAX_MEMORY];
extern int yylex();
int yyerror(const char *p) { printf("%s encountered\n",p); return 1; }
int var_i = 0;
%}

%token DATA_TYPE IDENTIFIER SEMICOLON COMMA CURLY_OPEN CURLY_CLOSE CIRC_OPEN CIRC_CLOSE 

%start lines

%union{

    int token;
    char* name;
}

%%
lines: /*empty*/
     | lines  line
     ;

//a line could be a function declaration or 
line: DATA_TYPE  id_list  SEMICOLON 
    | DATA_TYPE  IDENTIFIER  '('  ')'  '{'  lines  '}' { }
    | DATA_TYPE  IDENTIFIER  '('   id_list  ')'  '{'  lines  '}' { }
    ;

id_list: id_list  COMMA  id 
       | id 

id: IDENTIFIER {   } 
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
