%{

#include <stdio.h>
#include <string.h>
#include "y.tab.h"
#include "global.h"
int i;

char * varNames[SIZE] = { NULL };
char * varTypes[SIZE] = { NULL };
char * dType 
%}

DATA_TYPE  "int"|"float"|"double"|"char"
IDENTIFIER  [a-zA-Z_][a-zA-Z0-9_]*

%%

"#".*        ;
{DATA_TYPE}  { 
                i = 0;
                while(i <= dtype_i )
                {
                    if(strcmp(yytext,dTypeNames[i]) == 0)
                        break;
                    i++;
                }  
                
                if( i > dtype_i )
                {
                    yyerror("Unknown data type error");
                    exit(1); 
                }
                printf("DT");
                yylval = i;
                return DATA_TYPE; 
             }

{IDENTIFIER} { 
                if( var_i >= SIZE )
                {
                    yyerror("Identifier overflow error");
                    exit(1);
                }
                varNames[var_i] = malloc(sizeof(char)*yyleng);
                memcpy(varNames[var_i],yytext, yyleng);
                yylval = var_i;
                var_i++;
                printf("ID");
                return IDENTIFIER; 
             }


";"            { printf(";");  return SEMICOLON; }

","            { printf(","); return COMMA; }

"{"            { printf("{"); return CURLY_OPEN; }

"}"            { printf("}"); return CURLY_CLOSE; }

"("            { printf("("); return CIRC_OPEN; }

")"            { printf(")"); return CIRC_CLOSE; }

.            ;
%%


