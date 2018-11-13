%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include "y.tab.h"
    #include <assert.h>

    int yylval;
    extern char* yytext;
    extern char *varNames[];
    int varCounter = 0;
    int i=0;
    int isFound = 0;
%}

INTEGERS    [0-9]+
BRACKET     [()]
OPERATOR    [+-/*=]
VARIABLE    [a-zA-z_][a-zA-z0-9_]*

%%

quit.*        return EXIT;
exit.*        return EXIT;
info.*        return INFO;
"exp"         { 
#ifdef DEBUG_CALC 
                printf("EXP<>"); 
#endif
                return EXP; 
              }
{OPERATOR}  { 
#ifdef DEBUG_CALC
                printf("OPR<%c>",yytext[0]); 
#endif                
                return yytext[0]; 
            }
{INTEGERS}     { 
#ifdef DEBUG_CALC
                    printf("NUM<%s>",yytext); 
#endif      
                    yylval = atoi(yytext); return INTEGER; 
                }
{BRACKET}   { 
#ifdef DEBUG_CALC
                    printf("BRA<%c>",yytext[0]); 
#endif
                    return yytext[0]; 
            }

{VARIABLE}  { 
		isFound = 0;
		for(i=0; i<varCounter; i++)
		{
			if(strcmp(varNames[i],yytext) == 0)
			{
				isFound = 1;
				yylval = i;
				break;
			}
		}
		if(!isFound)
		{
                        assert(varCounter < 100);
                    
			varNames[varCounter] = malloc( sizeof(char) * yyleng );
		        memcpy(varNames[varCounter],yytext, sizeof(char) * yyleng);	
			yylval = varCounter++; 
			
		}
#ifdef DEBUG_CALC
                 printf("VAR<%s>",yytext);
#endif		
                return VARIABLE; 
	    }
\n          { 
#ifdef DEBUG_CALC
                printf("NWL<>"); 
#endif
                return NEWLINE; 
            }

[ \t]       ;
.           ;   
%%
