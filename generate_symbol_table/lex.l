%{

    #include <stdio.h>
    #include "y.tab.h"
    #include "global.h"
    #define LEX_DEBUG_H
    int curl_depth = 0;
%}

IDENTIFIER   [_a-zA-Z][_a-zA-Z0-9]*
DATA_TYPE    "int"|"float"|"double"|"char"
L_CURLY      "{"
R_CURLY      "}"


%%

{DATA_TYPE}   { 
#ifdef LEX_DEBUG_H
                printf("`DTY`");
#endif
                strcpy(currDataType, yytext);
                yylval.stringValue = strdup(yytext); return DATA_TYPE; }
"include"   { 
#ifdef LEX_DEBUG_H
                printf("`INC`");
#endif
                return INCLUDE; }
{IDENTIFIER}  { 
#ifdef LEX_DEBUG_H
                printf("`IDR`");
#endif
                yylval.stringValue = strdup(yytext); return IDENTIFIER; }
{L_CURLY}     { 
#ifdef LEX_DEBUG_H
                printf("`LCR`");
#endif
                curl_depth += 1; return L_CURLY; }
{R_CURLY}     { 
#ifdef LEX_DEBUG_H
                printf("`RCR`");
#endif
                
                curl_depth -= 1; 
                if(curl_depth < 0 )
                {
                        yyerror("Unbalanced Curly Braces ");
                        exit(1);
                }
                return R_CURLY;
            }
[;,()<>#"]      { 
#ifdef LEX_DEBUG_H
                printf("`SY%c`",yytext[0]);
#endif
                    return yytext[0]; }

\.            {
#ifdef LEX_DEBUG_H
                printf("`SY%c`",yytext[0]);
#endif
                    return yytext[0];
                }
.           ;

%%

