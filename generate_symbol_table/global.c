#include "global.h"

int yyerror(const char *p) { printf("%s encountered\n",p); return 1; }
