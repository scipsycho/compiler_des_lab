%{
    #include <stdio.h>
    #include "y.tab.h"
    int yylval;
    extern char* yytext;

    int varCounter = 0;
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
{VARIABLE}  { yylval = varCounter++; return VARIABLE; }
\n          { return NEWLINE; }
[ \t]       ;
.           ;   
%%
