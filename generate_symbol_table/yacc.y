%{
    
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "global.h"

#define MAX_MEMORY 1000

extern int yylex();
%}

%token DATA_TYPE IDENTIFIER SEMICOLON COMMA CURLY_OPEN CURLY_CLOSE CIRC_OPEN CIRC_CLOSE 

%start lines


%%
lines: /*empty*/
     | lines  line
     ;

//a line could be a function declaration or 
line: DATA_TYPE  id_list  SEMICOLON { }
    | DATA_TYPE  IDENTIFIER  CIRC_OPEN CIRC_CLOSE CURLY_OPEN lines CURLY_CLOSE { }
    | DATA_TYPE  IDENTIFIER  CIRC_OPEN   id_list  CIRC_CLOSE CURLY_OPEN  lines CURLY_CLOSE { }
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
