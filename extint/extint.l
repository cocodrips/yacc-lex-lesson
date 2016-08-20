%{ 
    #include <stdlib.h>
    #include "y.tab.h"
%}
D       [0-9]
N       [1-9]
O       [0-7]
H       [0-9a-fA-F]
%%
"+"     return (ADDOP);
"-"     return (SUBOP);
"*"     return (MULOP);
"/"     return (DIVOP);
"**"    return (POWOP);
"!"     return (FACTOP);
"("     return (LP);
")"     return (RP);
end     return (END);
{N}{D}* |
0{O}*   |
0(x|X){H}+ {
            yylval = strtol((char *)yytext, (char **)NULL, 0);
            return (NUMBER);
        }
[ \t]   ;
\n      return (NL);
.       return (yytext[0]);
%%