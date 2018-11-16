%{
    #include <stdio.h>
    #include <string.h>
    #include "global.h"
    #define MAX_VARS  1000

    struct symbolTableEntry
    {
        char scope[200];
        char name[100];
        char type[100];

    };

    struct symbolTableEntry symbolTable[MAX_VARS];
    int i_symbolTable = 0;
    char currDataType[100];
    char currScope[100];
    //int i_currScope = 0;
    
    extern int yylex();
    int yyerror(const char *p) { printf("%s\n",p); return 1; }
    
%}

%token IDENTIFIER DATA_TYPE INCLUDE L_CURLY R_CURLY NEWLINE
%start lines

%union
{
    char *stringValue;
    int intValue;
};

%%

lines: /*empty*/ 
     |lines stmt
     ;

stmt: '#' INCLUDE '<' IDENTIFIER '>' /*include statement do nothing*/   
    | '#' INCLUDE '<' IDENTIFIER '.' IDENTIFIER '>' /*include statement do nothing*/
    |  DATA_TYPE  id_list ';' 
    
    | func_decl  /*function declaration do nothing*/
    | func_def   /*function definition*/
    ;

func_decl: DATA_TYPE IDENTIFIER '(' ')' ';'
         | DATA_TYPE IDENTIFIER '(' pr_decl_list ')' ';'
         ;

pr_decl_list: DATA_TYPE IDENTIFIER
            | DATA_TYPE
            | pr_decl_list ',' DATA_TYPE
            | pr_decl_list ',' DATA_TYPE IDENTIFIER
            ;
            
func_def: DATA_TYPE IDENTIFIER '(' ')' L_CURLY lines R_CURLY
        | DATA_TYPE IDENTIFIER '(' pr_defn_list ')' L_CURLY lines R_CURLY
        ;

pr_defn_list: DATA_TYPE id
            | pr_defn_list ',' DATA_TYPE id
            ;

id_list: id
       | id_list ',' id
       ;
id: IDENTIFIER  {  
                    if(i_symbolTable >= MAX_VARS )
                    {
                            yyerror("Maximum limit reached");
                            return 1;
                    }
                    if(curl_depth == 0 )
                        strcpy(symbolTable[i_symbolTable].scope, "global"); 
                    else
                        strcpy(symbolTable[i_symbolTable].scope, currScope); 
                    strcpy(symbolTable[i_symbolTable].name,$<stringValue>1);
                    strcpy(symbolTable[i_symbolTable].type, currDataType);
            
                    i_symbolTable++;
                }
%%

int yywrap()
{
    return 1;
}
int main()
{
    yyparse();

    for(int i=0; i< i_symbolTable; i++)
        printf("%s %s %s\n",symbolTable[i].name, symbolTable[i].type, symbolTable[i].scope);

    printf("%d\n",i_symbolTable);
    printf("Hurray\n");

}
