/* file main.c :: limited to yyparse() call and printed result */
/* compilation: gcc -o main main.c parseur.tab.c lex.yy.c */
/* result: main = syntaxic analysis */
/* usage: ./main < input.txt */
#include <stdio.h> /* printf */
#include <stdlib.h> /* exit */
#include <math.h>
int main(void)
{
int yyparse();
if (yyparse()==0) { /* yyparse calls yylex */
printf("\nParsing:: syntax OK\n"); /* reached if parsing folllows the grammar*/
}
exit(EXIT_SUCCESS);
}
