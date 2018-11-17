%{

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "y.tab.h"
%}

INTEGER    [0-9]+
IDENTIFIER [_a-zA-Z][_a-zA-Z0-9]*
%%

exit.*      { return EXIT; }
quit.*      { return EXIT; }
{INTEGER}   { yylval.exp = strdup(yytext);  return INTEGER;}
{IDENTIFIER}   { yylval.exp = strdup(yytext);  return IDENTIFIER;}
[+-]        { yylval.exp = strdup(yytext);  return OPR1;  }
[/*]        { yylval.exp = strdup(yytext);  return OPR2;  }
[()]        { return yytext[0]; }
\n          { return NEWLINE; }
.           ;

%%
