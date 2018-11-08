%{

#include <stdio.h>
#include "y.tab.h"

extern char *varName[];

int allocCopy()
{
    yylval.name = malloc(sizeof(char)*yyleng); 
    memcpy(yylval.name, yytext, yyleng);
}

%}

DATA_TYPE  "int"|"float"|"double"|"char"
WHITESPACE  [ \t\n]+
IDENTIFIER  [a-zA-Z_][a-zA-Z0-9_]*

%%

{DATA_TYPE}  { 
                allocCopy();
                printf("DT<%s>",yylval.name);
                return DATA_TYPE; 
             }

{IDENTIFIER} { 
                allocCopy();
                printf("ID<%s>",yylval.name);
                return IDENTIFIER; 
             }


";"             return SEMICOLON;

","             return COMMA;

"{"             return CURLY_OPEN;

"}"             return CURLY_CLOSE;

"("             return CIRC_OPEN;

")"             return CIRC_CLOSE;

.            ;
%%


