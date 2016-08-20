%{  
    /* Fix warning C99 */
    #include <stdio.h>
    int yylex(void);
    void yyerror(const char *s);
%}

%token NL
%token NUMBER
%token LP
%token RP
%left ADDOP SUBOP
%left MULOP DIVOP
%%
s       : list
        ;
list    : /*empty*/
        | list expr NL      { printf("%d\n", $2); }
        ;
expr    : expr ADDOP expr   { $$ = $1 + $3; }
        | expr SUBOP expr   { $$ = $1 - $3; }
        | expr MULOP expr   { $$ = $1 * $3; }
        | expr DIVOP expr   { $$ = $1 / $3; }
        | LP expr RP        { $$ = $2; }
        | NUMBER            { $$ = $1; }
        ;
%%

# include "lex.yy.c"