%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int yylex(void);
int yyerror(const char*);
float T[26];
%}

%union { double dval; int ival; int index; }
%token <ival> INT
%token <dval> REEL
%token <index> ID
%type <ival> expression
%type <ival> condition
%type <ival> ifelse
%token IF ELSE PV PO PF RECOIT EQUAL NOTEQUAL INF SUP MOD FACT
%left PLUS MOINS
%left FOIS SUR
%left DIV
%left COS SIN LOG2 LOG EXP TAN SINH COSH TANH MOD
%nonassoc MOINSU
%start resultat
%%
resultat:
resultat expression PV {printf("Res= %d\n", $2);}
|resultat ifelse PV {printf("Res= %d\n", $2);}
| ifelse PV {printf("Res= %d\n", $1);}
| expression PV {printf("Res= %d\n", $1);}
;
ifelse:
IF PO condition PF expression {if ($3 == 1) {$$ = $5; printf("1er Condition est vrais\n");}}
| ifelse PV ELSE expression {if ($1) $$= $1; else {$$= $4; printf("2eme condition est vrais\n");}}
;
expression:
PO expression PF {$$ = $2;}
| expression PLUS expression {$$ = $1 + $3;}
| expression MOINS expression {$$ = $1 - $3;}
| expression FOIS expression {$$ = $1 * $3;}
| expression DIV expression {$$ = $1 / $3;}
| MOINS expression %prec MOINSU {$$ = -$2;}
| COS PO expression PF {$$ = cos($3);}
| SIN PO expression PF {$$ = sin($3);}
| TAN PO expression PF { $$ = tan($3); }
| COSH PO expression PF { $$ = cosh($3); }
| SINH PO expression PF { $$ = sinh($3); }
| TANH PO expression PF { $$ = tanh($3); }
| LOG PO expression PF { $$ = log10($3); }
| LOG2 PO expression PF { $$ = log2($3); }
| EXP PO expression PF {$$ = exp($3);}
| INT {$$ = (float)$1;}
| REEL {$$ = $1;}
| expression FACT { 
$$=1;
for(int i=1;i<=$1;i++)
{$$ =$$*i; }
}
| expression MOD expression { $$ = $1 % $3; }
| ID RECOIT expression {T[$1] = $3; $$ = $3;}
| ID {$$ = T[$1];}
;
condition:
expression EQUAL expression {if ($1 == $3) $$ = 1; else $$ = 0;}
| expression NOTEQUAL expression {if ($1 != $3) $$ = 1; else $$ = 0;}
| expression INF expression {if ($1 < $3) $$ = 1; else $$ = 0;}
| expression SUP expression {if ($1 > $3) $$ = 1; else $$ = 0;}
;
%%
#include <stdio.h> /* printf */
int yyerror(const char *msg){ printf("Parsing:: syntax error\n"); return 1;}
int yywrap(void){ return 1; } /* stop reading flux yyin */
