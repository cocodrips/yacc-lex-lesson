# /bin/sh -ex
yacc -d extint.y && lex extint.l && cc y.tab.c lex.yy.c -ly -ll -o extint
echo extint
