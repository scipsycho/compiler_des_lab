%{

#include <stdio.h>
#include <stdlib.h>


extern int yylex();
int yyerror(const char *p) { printf("%s encountered\n",p); return 1; }

int first = 1;
%}

%token NUMBER NEWLINE EXIT 
%left '+' '-'
%left '*' '/'

%start lines

%%

lines: /*empty*/
     | lines exp NEWLINE { printf("\n>> "); first=1; } 
     ;

exp: exp '+' exp { printf("%c ",'+'); }
   | exp '-' exp { printf("%c ",'-'); }
   | exp '/' exp { printf("%c ",'/'); }
   | exp '*' exp { printf("%c ",'*'); }
   | '(' exp ')' {  }
   | NUMBER {  
                if(first)
                {
                    first = 0;
                    printf("(Postfix) ");
                }
                printf("%d ",$1); }
   | EXIT { exit(0); }
   ;

%%

int yywrap()
{

    return 1;
}

int main()
{
    printf("Infix to Postfix Converter built using YACC and LEX\n");
    printf("Author: Dharmesh Singh (@scipsycho)\n");
    printf("Reserved keywords: exit, quit\n");
    printf(">> ");
    yyparse();
}
