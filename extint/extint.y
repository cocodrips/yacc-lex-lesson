%{  
    /* Fix warning C99 */
    #include <stdio.h>
    int yylex(void);
    void yyerror(const char *s);

    #define YYSTYPE long
    long lfact(long x);
    long lpower(long x, long y);
%}

%token  END
%token  NL
%token  NUMBER
%token  LP
%token  RP
%left   ADDOP SUBOP
%left   MULOP DIVOP
%right  UMINUS
%right  POWOP
%left   FACTOP
%start  s
%%
s       : list
            {   printf("bye~\n"); }
        ;
list    
        : /*empty*/
            {   printf(">> "); }
        | list line
            {   printf(">> "); }
        ;
line    
        : expr NL 
            {   printf("%ld, 0x%lx, 0o%lo\n", $1, $1, $1); }
        | END NL 
            {   printf("bye~\n"); 
                YYACCEPT; 
            }
        | error NL
        ;
expr    
        : expr ADDOP expr   
            {   $$ = $1 + $3; }
        | expr SUBOP expr   
            {   $$ = $1 - $3; }
        | expr MULOP expr   
            {   $$ = $1 * $3; }
        | expr DIVOP expr   
            {   if ($3 == 0) {
                    printf("0 devide\n");
                    YYERROR;
                }
                $$ = $1 / $3; 
            }
        | expr POWOP expr
            {   if ( $3 < 0 ) {
                    printf("negative power\n");
                    YYERROR;
                }
                $$ = lpower($1, $3);
            }
        | SUBOP expr %prec UMINUS 
            {
                $$ = -$2;
            }
        | expr FACTOP
            {   if ($1 < 0) {
                    printf("negative factorial\n");
                    YYERROR;                    
                }
                $$ = lfact($1);
            }
        | LP expr RP        
            { $$ = $2; }
        | NUMBER            
            { $$ = $1; }
        ;
%%

/* Power */
long lpower(long x, long y) {
    long i, pw;
    if (x == 0) { return (0); }
    else {
        pw = 1;
        for (i = y; i; --i) {
            pw *= x;
        }
        return (pw);
    }
}

/* Factorial*/
long lfact(long x) {
    long i, fc;
    for (fc = 1, i = x; i; --i) {
        fc *= i;
    }
    return (fc);
}
