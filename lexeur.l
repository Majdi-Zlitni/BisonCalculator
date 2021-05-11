/* file lexeur.l */
/* compilation: flex lexeur.l */
/* result: lex.yy.c = lexical analyser in C */
%{
#include <stdio.h> /* printf */
#include <math.h>
#include "parseur.tab.h" /* token constants def. in parseur.y via #define */
%}
n [0-9]
%%
"if"  {printf("if condition: %s\n", yytext); return IF; }
"else"  {printf("Else condition: %s\n", yytext); return ELSE; }
("Sin")|("sin")  {printf("sinus: %s\n", yytext); return SIN; }
("Cos")|("cos")  {printf("cosinus: %s\n", yytext); return COS; }
("Log2")|("log2")  {printf("Log base 2: %s\n", yytext); return LOG2; }
("Log")|("log")  {printf("Log: %s\n", yytext); return LOG; }
("Exp")|("exp")  {printf("exponetielle: %s\n", yytext); return EXP; }
("tan")|("Tan")	  {printf("TAN: %s\n", yytext); return TAN; }
("sinh")|("Sinh") {printf("SINH: %s\n", yytext); return SINH; }
("cosh")|("Cosh") {printf("COSH: %s\n", yytext); return COSH; }
("tanh")|("Tanh") {printf("TANH: %s\n", yytext); return TANH; }
("mod")|("Mod")	  {printf("MOD: %s\n", yytext); return MOD; }
[a-z]  {printf("ID: %s\n", yytext); yylval.index= yytext[0]-'a'; return ID; }
{n}+  {printf("INT: %s\n", yytext); yylval.ival= atoi(yytext); return INT;}
{n}+\.{n}* |
{n}*\.{n}+  {printf("reel: %s\n", yytext); yylval.dval= atof(yytext); return REEL; }
"+"  {printf("PLUS: %s\n", yytext); return PLUS; }
"-"  {printf("MOINS: %s\n", yytext); return MOINS; }
"*"  {printf("FOIS: %s\n", yytext); return FOIS; }
"/"  {printf("DIV: %s\n", yytext); return DIV; }
"("  {printf("PO: %s\n", yytext); return PO; }
")"  {printf("PF: %s\n", yytext); return PF; }
"!"  {printf("FACT: %s\n", yytext); return FACT; }
"="  {printf("RECOIT: %s\n", yytext); return RECOIT; }
"==" {printf("EQUAL: %s\n", yytext); return EQUAL; }
"!=" {printf("NOTEQUAL: %s\n", yytext); return NOTEQUAL; }
"<"  {printf("INF: %s\n", yytext); return INF; }
">"  {printf("SUP: %s\n", yytext); return SUP; }
";"  {printf("PV: %s\n", yytext); return PV; }
[ \t\n] { ; } /* ignore space, tab, and line return */
. { printf("char: %s\n",yytext); return yytext[0]; }
%%
