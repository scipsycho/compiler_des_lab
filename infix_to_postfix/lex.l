%{

    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"
%}

OPERATORS  [+-/*]
NUMBER    [0-9]+

%%

exit.*      { return EXIT; }
quit.*      { return EXIT; }
{NUMBER}    { yylval = atoi(yytext);  return NUMBER;}
{OPERATORS} { return yytext[0]; }
[()]        { return yytext[0]; }
\n          { return NEWLINE; }
.           ;

%%
