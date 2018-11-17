%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
int yyerror(const char *p) { printf("%s\n",p); return 1; }

char *concat( const char* s1, const char* s2, const char*s3)
{
    int len = strlen(s1) + strlen(s2) + strlen(s3) + 1;
    char *s = malloc(sizeof(char)*len);

    int i=0;
    for(int j=0; s1[j]!='\0'; j++)
        s[i++] = s1[j];
    for(int j=0; s2[j]!='\0'; j++)
        s[i++] = s2[j];
    for(int j=0; s3[j]!='\0'; j++)
        s[i++] = s3[j];

    s[i] = '\0';

    return s;
}
%}


%union
{
    char *exp;
    int val;
};
%token INTEGER IDENTIFIER OPR1 OPR2 NEWLINE EXIT 
%left OPR1
%left OPR2

%start lines

%%

lines: /*empty*/
     | lines exp NEWLINE { printf("%s\n>> ",$<exp>2); } 
     ;

exp: exp OPR1 exp { $<exp>$ = concat($<exp>2,$<exp>1,$<exp>3); }
   | exp OPR2 exp { $<exp>$ = concat($<exp>2,$<exp>1,$<exp>3); }
   | '(' exp ')'  { $<exp>$ = $<exp>2; }
   | INTEGER      { $<exp>$ = concat(" ",$<exp>1," "); } 
   | IDENTIFIER   { $<exp>$ = concat(" ",$<exp>1," "); } 
   | EXIT { exit(0); }
   ;

%%

int yywrap()
{

    return 1;
}

int main()
{
    printf("Infix to Prefix Converter built using YACC and LEX\n");
    printf("Author: Dharmesh Singh (@scipsycho)\n");
    printf("Reserved keywords: exit, quit\n");
    printf(">> ");
    yyparse();
}
