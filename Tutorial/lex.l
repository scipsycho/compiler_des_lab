%%

[a-zA-Z_][a-zA-Z_0-9]* { printf("ID"); }
[;(){},]                { printf("%c",yytext[0]); }
.                      ;

%%

int yywrap()
{
    return 1;
}
int main()
{
    yylex();
}
