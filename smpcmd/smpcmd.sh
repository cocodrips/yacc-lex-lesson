# /bin/sh -ex
yacc smpcmd.y && lex smpcmd.l && cc y.tab.c -ly -ll -o scalc