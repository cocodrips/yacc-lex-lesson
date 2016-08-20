%{
    /* Fix warning C99 */
    # include <stdio.h>
    int yylex(void);
    void yyerror(const char *s);

    # include <stdlib.h>
    # include <string.h>
    static char source[256] = {0};
    static char target[256] = {0};
    static char buf[512] = {0};
%}

%token  NL
%token  COPY
%token  MOVE
%token  REMOVE
%token NAME
%%
s       : list
        ;
list    : /*empty*/
        | list expr NL
        ;
expr    : COPY source target {
            sprintf (buf, "cp %s %s", source, target);
            system(buf); }
        | MOVE source target {
            sprintf (buf, "mv %s %s", source, target);
            system(buf); }
        | REMOVE target {
            sprintf (buf, "rm %s", target);
            system(buf); }
        ;
source  : NAME
            { strcpy(source, $1); }
        ;
target  : NAME
            { strcpy(target, $1); }
        ;
%%
# include "lex.yy.c"