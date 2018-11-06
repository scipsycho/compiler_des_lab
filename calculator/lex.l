%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include "y.tab.h"
    #include "global.h"

    int yylval;
    extern char* yytext;
    extern char* varNames[];
    int varCounter = 0;
    int i=0;
    int isFound = 0;
%}

DIGIT       [0-9]+
BRACKET     [()]
OPERATOR   [+-/*=]
VARIABLE    [a-zA-z_][a-zA-z0-9_]*

%%

quit        return EXIT;
exit        return EXIT;
{OPERATOR}  { return yytext[0]; }
{DIGIT}     { yylval = atoi(yytext); return NUMBER; }
{BRACKET}   { return yytext[0]; }
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
			varNames[varCounter] = malloc( sizeof(char) * yyleng );
		        memcpy(varNames[varCounter],yytext, sizeof(char) * yyleng);	
			yylval = varCounter++; 
			
		}
		return VARIABLE; 
	    }
\n          { return NEWLINE; }
[ \t]       ;
.           ;   
%%
