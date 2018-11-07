
test: SHELL:=/bin/bash
test: yacc.y lex.l
	yacc yacc.y -d
	lex lex.l
	cc y.tab.c lex.yy.c -o test

clean: SHELL:=/bin/bash
clean:
	echo "This will clean all the files except these: "
	echo "Makefile"
	echo "yacc.y"
	echo "lex.l"
	echo "global.h"
	rm `ls -1 | grep -v "\(lex.l\)\|\(yacc.y\)\|\(Makefile\)\|\(global\)"` 
