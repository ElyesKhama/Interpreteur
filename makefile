all: interpreteur

lex.yy.c: interpreteur.l
	./flex interpreteur.l

interpreteur.tab.c: interpreteur.y
	bison -d -v interpreteur.y

interpreteur: interpreteur.tab.c lex.yy.c
	gcc -g -o interpreteur lex.yy.c interpreteur.tab.c libfl.a /usr/share/bison/liby.a

test: interpreteur 
	./interpreteur < instruction.asm

