test: yacc.y lex.l
	yacc yacc.y -d
	lex lex.l
	cc y.tab.c lex.yy.c -o test

clean:
	echo "This will clean all the files except these: "
	echo "Makefile"
	echo "yacc.y"
	echo "lex.l"
	echo "Do you want to continue (y/n)?"
	read choice
	if [ "${choice}" = "y" ] | [ "${choice}" ="Y" ]; then rm `ls -1 | grep -v "\(lex.l\)\|\(yacc.y\)\|\(Makefile\)"` ; fi
