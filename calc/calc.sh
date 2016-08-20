# /bin/sh -ex
yacc calc.y && lex calc.l && cc y.tab.c -ly -ll -o calc